FROM debian:bullseye-slim
LABEL maintainer="smasherofallthings"
LABEL description="A base image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN printf "$(date --iso-8601=seconds)" > /etc/build-date

ENTRYPOINT [ "/bin/bash" ]