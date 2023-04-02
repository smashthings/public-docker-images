ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image that contains both flask and waitress - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
python3 \
python3-pip \
bash 

RUN python3 -m pip install \
requests \
PyYaml \
names \
bitstring \
Flask \
waitress

ENTRYPOINT [ "python3" ]