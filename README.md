# Public Docker Images

These are publicly available docker images on docker hub that I use privately and when consulting. I've built them as I've found the practicalities of what I want and what the rest of the world provides to be out of sync as explained in the use cases below. All images can be pulled from docker hub under smasherofallthings/<iamge-name> with nightly builds under the following tags:

*Latest* - Always updated and always pointing to the latest build
*Dated* - Dated to format %Y-%m-%d and build number *b<build-number>*, eg. 2022-05-01-b13


## Images

### Base Image
This is just the version of debian that all images are built off of. Current release - Bullseye

*Use Case:* Build image

### Debug
Debug is a fully featured debian image used for debugging. It contains many of the tools I expect on a provisioned sysadmin machine such as nslookup, curl, ps and more. With images becoming more "secure" by removing root on running containers whilst still running shit software that doesn't log or handle errors correctly, it suits to have an on hand image to load into an environment.

This image will always be quite large in size as it includes software such as:

- curl
- A recent bash shell (should be 4.x)
- file (what type of data am I getting from this endpoint)
- jq
- nslookup
- rsync
- The AWS CLI
- Python3 with some decent libraries

Example K8s Usage:

> kubectl run -it --rm --image=smasherofallthings/debug smasherofallthingsdebugger -- bash

*Use Case:* Quickly loaded into Kubernetes clusters to debug DNS/linkerd, curl service endpoints, etc

### docker
The base image with both the docker CLI and docker-compose added to it. Does not include the docker engine itself, this is not a Docker in Docker image.

*Use Case:* Building docker images!

### flask-waitress
There are flask images, there are waitress images but I struggled to find an image with both flask and waitress with a full supply chain for the image itself.

*Use Case:* A production image for a flask app hosted by waitress as an appropriate runtime

### Certbot K8s
Takes the certbot base image and installs kubectl and the AWS CLI as well. This is done so so that you can run the certbot image alongside scripts for writing the certs to K8s secrets, sending them to AWS and/or updating DNS records in AWS Route53 for DNS validation.

*Use Case:* As advised above, this is exactly what I do with my PKI management with the script run on a K8s cronjob

### Python FE
This is a specialised image that I use for the selected frontend technologies that I develop in and backend python web services. It's the flask-waitress image with a hint of NPM development tools, intended to be run locally.

*Use Case:* Running on a local development machine with code mounted as a volume allowing for python and especially node development code to be run in isolation. The JS environment and landscape is too insecure to be run directly on my development machine, this gives me that boundary to build tailwind, solidjs, etc whilst still being able to run the Flask application

### Hugo
For some reason Hugo doesn't release docker images, so this is a docker image that includes Hugo and some base packages such as git and curl

*Use Case:* CICD pipeline image for Hugo


## WIP

### Latest Python
This is an advanced python installation over the top of the base Debian image. I've not needed to go cutting edge on python yet but this was an interesting framework to work along 

### Buildah
An image containing buildah configuration to get it to work as a docker in docker replacement. Reasonable amounts of debugging went into getting this working and it worked in the majority of cases with some issues around GID and UID settings on some particular builds (ie, Gitea). Mostly use docker socker exposed images for builds these days instead for ease of use and the fact that a compromised build agent is going to be devastating docker or not. I'm not currently running a bank so ROI isn't worth it


