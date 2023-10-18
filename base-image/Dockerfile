ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN printf "$(date --iso-8601=seconds)" > /etc/build-date

RUN apt-get update && apt-get install -y less nano

ENTRYPOINT [ "/bin/bash" ]