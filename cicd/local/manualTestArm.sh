#!/bin/bash

if [[ -z $1 ]]; then
  printf "You must provide the name of the directory to build! For example:\n\n$ bash cicd/local/manualTest.sh base-image\n"
  exit 1
fi

Tag="${2:-arm7-latest}"

set -e

docker buildx build -t smasherofallthings/$1:$Tag -f "$1/${ArmDockerfile:-Dockerfile}" --platform linux/arm/v7 --output type=docker $1

printf "\nBuilt smasherofallthings/$1:$Tag\n\n"

