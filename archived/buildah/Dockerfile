FROM debian:sid
LABEL maintainer="smasherofallthings"
LABEL description="A debugging image utilsing debian testing for container management via Buildah - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
buildah \
python3 \
python3-pip \
curl \
bash \
bash-completion \
file \
jq \
net-tools \
dnsutils \
tar \
rsync \
tcpdump \
make

COPY artefacts/docker.sh /usr/bin/docker
RUN chmod a+x /usr/bin/docker

COPY artefacts/containers.conf /etc/containers/containers.conf
RUN mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock; touch /var/lib/shared/vfs-images/images.lock; touch /var/lib/shared/vfs-layers/layers.lock

# Define uid/gid ranges for our user https://github.com/containers/buildah/issues/3053
RUN echo build:2000:50000 > /etc/subuid \
 && echo build:2000:50000 > /etc/subgid

VOLUME /var/lib/containers
VOLUME /home/build/.local/share/containers

# Set an environment variable to default to chroot isolation for RUN
# instructions and "buildah run".
ENV BUILDAH_ISOLATION=chroot


ENTRYPOINT [ "/bin/bash" ]