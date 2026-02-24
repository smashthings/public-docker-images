ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image that contains main frontend node tools (SolidJS, esbuild, etc) and python for server work - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  libpq-dev \
  build-essential \
  curl

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"
ENV VIRTUAL_ENV=/opt/venv

RUN uv venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3 -m pip install \
  requests \
  PyYaml \
  Jinja2 \
  boto3 \
  Flask \
  Flask-SQLAlchemy \
  sqlobject \
  psycopg2 \
  waitress \
  pytest \
  jinny \
  twine \
  build

CMD ["/bin/bash"]
