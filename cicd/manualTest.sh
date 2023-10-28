#!/bin/bash

set -e

docker build -t smasherofallthings/$1:amd64-latest $1/

docker buildx build -t smasherofallthings/$1:arm7-latest -f "$1/${ArmDockerfile:-Dockerfile}" --platform linux/arm/v7 --output type=docker $1

