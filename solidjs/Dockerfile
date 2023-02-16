FROM smasherofallthings/base-image:latest
LABEL maintainer="smasherofallthings"
LABEL description="An image that contains SolidJS for frontend development - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN apt-get update && apt-get install -y \
  curl \
  xz-utils \
  lsb-release \
  git

# Version set to 16.13.1
RUN mkdir -p /tmp/node && curl https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz -o /tmp/node/node.tar.xz

RUN mkdir -p /usr/local/lib/nodejs && tar -xJvf /tmp/node/node.tar.xz -C /usr/local/lib/nodejs
RUN mv /usr/local/lib/nodejs/*/* /usr/local/lib/nodejs/ && rm -rf /usr/local/lib/nodejs/node-v*-x64
ENV PATH="/usr/local/lib/nodejs/bin:${PATH}"
RUN node -v && npm version && npx -v

RUN npm install -g solid-js babel-preset-solid esbuild esbuild-plugin-solid nodemon livereload npm-run-all browser-sync

ENTRYPOINT [ "bash" ]