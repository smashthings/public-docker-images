FROM smasherofallthings/solidjs:latest
LABEL maintainer="smasherofallthings"
LABEL description="An image that contains main frontend node tools (SolidJS, esbuild, etc) and python for server work - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip

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
  waitress