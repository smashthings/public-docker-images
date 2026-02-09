ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base python image that loads in a virtual environment for python away from system installations - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  libpq-dev \
  build-essential

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

CMD ["/bin/bash"]