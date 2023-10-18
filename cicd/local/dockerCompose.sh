#!/bin/bash

if [[ -z $1 ]]; then
  printf "You must provide the name of the directory to build! For example:\n\n$ bash cicd/local/dockerCompose.sh base-image\n"
  exit 1
fi

currDir=$(pwd)
trap "cd ${currDir};" EXIT

set -e
scriptDir=$(realpath $(dirname ${0}))
cd "${scriptDir}/../../${1}"

docker-compose build

printf "\nBuilt smasherofallthings/$1\n\n"
printf 'Push image (Y/n)?\n'

read pushConf

if [[ -z $pushConf ]] || [[ $pushConf =~ (Yes|Y|y|yes) ]]; then
  docker-compose push
fi

