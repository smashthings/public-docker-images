ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="An image for running certbot in K8s, ie with AWS CLI and kubectl added - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apk add curl bash rsync jq bind-tools aws-cli && aws --version

# RUN mkdir /tmp/awsv2 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awsv2/awscliv2.zip" && unzip /tmp/awsv2/awscliv2.zip -d /tmp/awsv2 && /tmp/awsv2/aws/install

RUN curl -fL --retry 3 --retry-delay 1 --retry-all-errors -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -fL --retry 3 --retry-delay 1 --retry-all-errors -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod a+x /usr/bin/kubectl && (kubectl version || exit 0)

RUN mkdir /tmp/doctl && curl -fL --retry 3 --retry-delay 1 --retry-all-errors -s https://github.com/digitalocean/doctl/releases/download/v1.76.2/doctl-1.76.2-linux-amd64.tar.gz -o /tmp/doctl/doctl.tar.gz && tar -xvf /tmp/doctl/doctl.tar.gz -C /tmp/doctl && mv /tmp/doctl/doctl /usr/bin/ && rm -rf /tmp/doctl && doctl version