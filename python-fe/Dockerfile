FROM smasherofallthings/solidjs:latest
LABEL maintainer="smasherofallthings"
LABEL description="An image that contains main frontend node tools (SolidJS, esbuild, etc) and python for server work - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  python3-venv

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian  buster stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

RUN python3 -m pip install \
  kubernetes \
  prometheus-client \
  requests \
  awscli \
  PyYaml \
  names \
  jmespath \
  Jinja2 \
  boto3 \
  bitstring \
  Flask \
  waitress \
  pytest \
  build \
  flask_sqlalchemy \
  sqlalchemy_utils \
  twine
