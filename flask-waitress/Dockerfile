ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image that contains both flask and waitress - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
python3 \
python3-pip \
python3-yaml \
python3-requests \
python3-flask \
python3-waitress \
python3-bitstring

ENTRYPOINT [ "python3" ]