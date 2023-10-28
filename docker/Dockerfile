ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base image with Docker CLI and Docker Compose - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
curl \
lsb-release \
gnupg \
ca-certificates

RUN install -m 0755 -d /etc/apt/keyrings

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list

RUN apt update && apt install -y docker-buildx-plugin docker-ce-cli docker-compose-plugin

RUN mkdir -p /root/.docker/cli-plugins && curl -s -L "https://github.com/docker/buildx/releases/download/v0.3.0/buildx-v0.3.0.linux-amd64" > /root/.docker/cli-plugins/docker-buildx && chmod a+x /root/.docker/cli-plugins/docker-buildx

ENTRYPOINT [ "/bin/bash" ]