FROM smasherofallthings/solidjs:amd64-latest
LABEL maintainer="smasherofallthings"
LABEL description="An image that contains main frontend node tools (SolidJS, esbuild, etc) and python for server work - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  libpq-dev \
  build-essential \
  cargo \
  libssl-dev \
  libffi-dev

RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

RUN python3 -m pip install \
  requests \
  PyYaml \
  Jinja2 \
  boto3 \
  Flask \
  waitress \
  pytest \
  jinny \
  twine
