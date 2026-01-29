ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A base debugging image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt update && apt install -y \
curl \
file \
jq \
net-tools \
dnsutils \
tar \
rsync \
tcpdump \
make \
git \
unzip \
lsb-release \
gnupg

RUN curl -fL --retry 3 --retry-delay 1 --retry-all-errors -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -fL --retry 3 --retry-delay 1 --retry-all-errors -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod a+x /usr/bin/kubectl

RUN curl -fL --retry 3 --retry-delay 1 --retry-all-errors https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_linux_amd64.zip -o /tmp/terraform.zip && unzip /tmp/terraform.zip -d /tmp/ && mv /tmp/terraform /usr/bin/ && rm -rf /tmp/terraform.zip

RUN mkdir /tmp/awsv2 && curl -fL --retry 3 --retry-delay 1 --retry-all-errors "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install

CMD [ "/bin/bash" ]