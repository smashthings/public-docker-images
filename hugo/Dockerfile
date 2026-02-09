ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image that contains Hugo for static site generation"

ARG Version
ARG Arch

RUN apt update && apt install -y \
curl \
git \
ssh \
imagemagick \
unzip \
rsync

RUN git config --system --add safe.directory /hugo

RUN curl -fL --retry 3 --retry-delay 1 --retry-all-errors https://github.com/gohugoio/hugo/releases/download/v${Version}/hugo_${Version}_linux-${Arch}.deb -o /tmp/hugo.deb && apt install -y /tmp/hugo.deb && rm -rf /tmp/hugo.deb && hugo version

RUN mkdir /tmp/awsv2 && curl -fL --retry 3 --retry-delay 1 --retry-all-errors "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install

CMD ["/bin/bash"]