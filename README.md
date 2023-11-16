# Public Docker Images

These are publicly available docker images hosted on docker hub. They're used frequently for internal builds as well as consultancy work. All images can be pulled from docker hub under smasherofallthings/<iamge-name>. Each weekly build is tagged individually with the date and build number. `latest` points to the most recent build:

`latest` - Updated weekly with a manifest pointing to either the amd64 or armv7 build \
`dated` - Dated to format %Y-%m-%d and build number *b<build-number>*, eg. `2022-05-01-b13`

All images are now based off of debian bookworm, ie. Debian 12 released in 2023.

> Please use the dated images where possible. These images will encounter breaking changes as they're updated over time.

## Images

### Base Image
This is a base build with a dated file at `/etc/build-date` and some basic packages such as `bash`, `less` and `nano` added.

*Use Case:* Base image for everything else in this repo

### Debug
Debug is a fully featured image used for debugging. It contains many of the tools I expect on a provisioned sysadmin machine such as `nslookup`, `curl`, `ps` and more. Debugging applications and environments can be a nightmare, especially with the poor quality of logging, configuration checks and other missing or bad patterns. Additionally, images are being stripped by "secure" processes breaking the ability to do anything useful inside of running containers. The debug images provides a fully kitted out debian image to work in.

This image will always be quite large in size as it includes software such as:

- kubectl
- The AWS CLI
- Terraform
- DNS utils
- File system tools, eg `file`
- Comms tools, eg `jq`

Example K8s Usage:

> kubectl run -it --rm --image=smasherofallthings/debug smasherofallthingsdebugger -- bash

*Use Case:* Quickly loaded into Kubernetes clusters to debug DNS/linkerd, curl service endpoints, etc

### backup
An image with some basic backup tools such as `rclone`, `zip`, `unzip` and `aws-cli` (ie. S3 cli)

*Use Case:* Zipping or rcloning to cloud providers

### docker
The base image with both docker CLI tools and docker compose added to it. Does not include the docker engine itself, as the intention is for this image to mount onto the host's docker socket using a volume (eg. `/var/run/docker.sock:/var/run/docker.sock`). This is not a docker-in-docker style image, it is exactly made and intended for use with a mounted docker socket.

For more details read [this article](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) by the original creator of docker-in-docker.

*Use Case:* Building docker images!

### flask-waitress
There are flask images, there are waitress images but I struggled to find an image with both flask and waitress with a full supply chain for the image itself. With debian bookworm this is built from system packages, allowing for flask and waitress to be available globally.

*Use Case:* A production image for a flask app hosted by waitress as an appropriate runtime

### Certbot K8s
Takes the certbot base image and installs kubectl and the AWS CLI as well. This is done so so that you can run the certbot image alongside scripts for writing the certs to K8s secrets, sending them to AWS and/or updating DNS records in AWS Route53 for DNS validation.

*Use Case:* A K8s cronjob for requesting and updating certificates from certbot

### Python FE
This is a specialised image using selected frontend technologies with backend python web services. It's the solidjs image with python added over the top and a boatload of common packages. These packages are loaded into a virtual environment at `/opt/venv`.

*Use Case:* Local development for projects [such as this](https://github.com/smashthings/s3proxy)

### SolidJS
Contains a fully featured SolidJS / TailwindCSS build environment. Used for local development without dealing with NodeJS installation pain. `nvm` is like a 5k shell script, I don't want to deal with that if it goes wrong.

*Use Case:* Local frontend development using solidjs, nodemon and tailwind to generate frontend artefacts to a mounted volume using a controlled NodeJS version

### Go Dev
The SolidJS image with Go installed. Now you can nodemon your go files.

*Use Case:* nodemon for go + frontend development

### Hugo
For some reason Hugo doesn't release docker images, so this is a docker image that includes Hugo and some base packages such as `git` and `curl`

*Use Case:* CICD pipeline image for Hugo
