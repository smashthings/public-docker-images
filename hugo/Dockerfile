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
