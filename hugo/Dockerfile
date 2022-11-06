FROM smasherofallthings/solidjs:latest
LABEL maintainer="smasherofallthings"
LABEL description="An image that contains Hugo for static site generation"

RUN apt-get update && apt-get install -y \
curl \
git \
ssh \
imagemagick \
rsync

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-64bit.deb -o /tmp/hugo.deb && apt-get install /tmp/hugo.deb && rm -rf /tmp/hugo.deb && hugo version

RUN mkdir /tmp/awsv2 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install
