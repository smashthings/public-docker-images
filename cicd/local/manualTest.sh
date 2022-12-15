#!/bin/bash

if [[ -z $1 ]]; then
  printf "You must provide the name of the directory to build! For example:\n\n$ bash cicd/local/manualTest.sh base-image\n"
  exit 1
fi

Tag="${2:-amd64-latest}"

set -e

docker build -t smasherofallthings/$1:$Tag $1/

printf "\nBuilt smasherofallthings/$1:$Tag\n\n"

