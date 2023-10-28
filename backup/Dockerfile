ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image containing backup utilities - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
curl \
rclone \
zip \
rsync \
ssh \
unzip

RUN mkdir /tmp/awsv2 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install

ENTRYPOINT [ "/bin/bash" ]