# Public Docker Images

These are publicly available docker images on docker hub that I use privately and when consulting. I've built them as I've found the practicalities of what I want and what the rest of the world provides to be out of sync. Rather than continue to butcher other people's images into the shape I want I've made these available everywhere via Docker Hub who kindly host. In no particular order:

### Base Image
This is just the version of debian that I am currently building off. By building it here I can change the base for all images I use.

### Debug
Debug is a well featured image that I use for debugging. It contains many of the tools that I use for trying to get stuff to work and finding out what's gone on in environments.

**It has never and probably will never be small, nor is it intended to be so**

You use it essentially as a shell into an environment - such as a k8s cluster - and use the tools it provides for debugging what's going on, ie is Linkerd busted again, can I curl the port that is meant to be giving a response, etc

It includes good stuff like:

- curl
- A recent bash shell (should be 4.x)
- nano (vi is in most systems but I prefer nano when things are pressured)
- file (what type of data am I getting from this endpoint)
- jq
- nslookup
- rsync
- less
- The AWS CLI
- Python3 with some decent libraries

Example K8s Usage:

> kubectl run -it --rm --image=smasherofallthings/debug smasherofallthingsdebugger -- bash

### flask-waitress
I could find flask images, but not any that easily/trustworthy enough also included waitress so that I can run my flask apps with an appropriate WSGI server. This is that image


### Latest Python
Debian stays stable which is great, however, some devs just have to have the latest features. One day I may also be that jerk. Hence this is a method for taking python's debian build process and placing it over the top of the base image so that I can still have a shell and all the other things I care about. This work is not complete and is still in progress. It's not a priority so I don't know if it'll get done soon, it's there if you would like a look though.


### Certbot K8s
Takes the certbot base image and installs kubectl and the aws CLI over the top. This is done so so that you can run the certbot image in a K8s pod along with a serviceaccount update a Route53 hosted zone with the certbot challenge and then update a K8s secret with all the resulting PKI. This is what fits my use case at least but you can muck around with it to fit yours.

### Python FE
This is a mash between the frontend image containing all the js stuff that I don't want running natively on my machine, and the python backend which is usually flask and waitress based.
