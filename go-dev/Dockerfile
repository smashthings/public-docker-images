ARG BaseImage
FROM ${BaseImage}
ARG GoVersion

LABEL maintainer="smasherofallthings"
LABEL description="An image that contains Go built on top of the current solidjs image - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN curl -fL --retry 3 --retry-delay 1 --retry-all-errors -o /tmp/${GoVersion} https://go.dev/dl/${GoVersion} && mkdir -p /usr/local/go && rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/${GoVersion}

ENV PATH="/usr/local/go/bin:${PATH}"
RUN go version

# go get support
RUN apt update && apt install -y ca-certificates git-core ssh

ENTRYPOINT [ "bash" ]
