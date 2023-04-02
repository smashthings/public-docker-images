ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base image with Docker CLI and Docker Compose - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
bash \
bash-completion \
curl \
lsb-release \
gnupg

RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli docker-compose

ENTRYPOINT [ "/bin/bash" ]