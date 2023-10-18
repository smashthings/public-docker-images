#!/bin/bash

if [[ -z $1 ]]; then
  printf "You must provide the name of the directory to regenerate the manifest for! For example:\n\n$ bash cicd/local/latestManifest.sh base-image\n"
  exit 1
fi

set -e

docker push smasherofallthings/$1:amd64-latest

docker manifest create "smasherofallthings/${1}:latest" --amend "smasherofallthings/$1:amd64-latest"
docker pull "smasherofallthings/${1}:latest"
printf "\nRecreated smasherofallthings/$1:latest manifest\n\n"

