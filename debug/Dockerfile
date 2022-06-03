FROM smasherofallthings/base-image:latest
LABEL maintainer="smasherofallthings"
LABEL description="A base debugging image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
python3 \
python3-pip \
curl \
bash \
bash-completion \
nano \
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
less

RUN curl -L -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod a+x /usr/bin/kubectl

RUN curl https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_linux_amd64.zip -o /tmp/terraform.zip && unzip /tmp/terraform.zip -d /tmp/ && mv /tmp/terraform /usr/bin/ && rm -rf /tmp/terraform.zip

COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt

RUN mkdir /tmp/awsv2 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install

ENTRYPOINT [ "/bin/bash" ]