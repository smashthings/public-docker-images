#!/bin/bash

set -e

docker buildx build -t smasherofallthings/$1:arm7-latest -f "$1/${ArmDockerfile:-Dockerfile}" --platform linux/arm/v7 --output type=docker $1

