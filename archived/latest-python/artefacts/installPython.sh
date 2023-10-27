#/bin/bash

LANG='C.UTF-8'
GPG_KEY='E3FF2839C048B25C084DEBE9B26995E310250568'
PYTHON_VERSION='3.9.5'

set -eux;
apt update
apt install -y --no-install-recommends ca-certificates netbase tzdata
rm -rf /var/lib/apt/lists/*

set -ex \
  && wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
  && wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$GPG_KEY" \
  && gpg --batch --verify python.tar.xz.asc python.tar.xz \
  && { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
  && rm -rf "$GNUPGHOME" python.tar.xz.asc \
  && mkdir -p /usr/src/python \
  && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
  && rm python.tar.xz \
  \
  && cd /usr/src/python \
  && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
  && ./configure \
    --build="$gnuArch" \
    --enable-loadable-sqlite-extensions \
    --enable-optimizations \
    --enable-option-checking=fatal \
    --enable-shared \
    --with-system-expat \
    --with-system-ffi \
    --without-ensurepip \
  && make -j "$(nproc)" \
  && make install \
  && rm -rf /usr/src/python \
  \
  && find /usr/local -depth \
    \( \
      \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
      -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' -o -name '*.a' \) \) \
    \) -exec rm -rf '{}' + \
  \
  && ldconfig \
  \
  && python3 --version

# make some useful symlinks that are expected to exist
cd /usr/local/bin \
  && ln -s idle3 idle \
  && ln -s pydoc3 pydoc \
  && ln -s python3 python \
  && ln -s python3-config python-config

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
PYTHON_PIP_VERSION='21.1.1'
# https://github.com/pypa/get-pip
PYTHON_GET_PIP_URL='https://github.com/pypa/get-pip/raw/1954f15b3f102ace496a34a013ea76b061535bd2/public/get-pip.py'
PYTHON_GET_PIP_SHA256='f499d76e0149a673fb8246d88e116db589afbd291739bd84f2cd9a7bca7b6993'

set -ex; \
  wget -O get-pip.py "$PYTHON_GET_PIP_URL"; \
  echo "$PYTHON_GET_PIP_SHA256 *get-pip.py" | sha256sum --check --strict -; \
  python get-pip.py \
    --disable-pip-version-check \
    --no-cache-dir \
    "pip==$PYTHON_PIP_VERSION" 
pip --version
find /usr/local -depth \
  \( \
    \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
    -o \
    \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
  \) -exec rm -rf '{}' +

rm -f get-pip.py
