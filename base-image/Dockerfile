ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN printf "$(date --iso-8601=seconds)" > /etc/build-date

RUN apt update && apt install -y less nano bash bash-completion

ENTRYPOINT [ "/bin/bash" ]