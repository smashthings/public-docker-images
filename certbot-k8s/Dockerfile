FROM certbot/certbot
LABEL maintainer="smasherofallthings"
LABEL description="An image for running certbot in K8s, ie with AWS CLI and kubectl added - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN python3 -m pip install awscli
RUN curl -L -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod a+x /usr/bin/kubectl

