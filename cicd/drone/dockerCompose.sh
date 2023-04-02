#!/bin/bash

set -e

cd "${IMAGE_NAME}"

if [[ ! -z $SkipArmBuild ]] && [[ $SkipArmBuild == "true" ]]; then
  printf "Skipping arm builds...\n"
fi

docker compose build
Tag="$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" docker compose build
docker compose push
Tag="$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" docker compose push

if [[ -z $SkipArmBuild ]]; then
  docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/${IMAGE_NAME}:arm7-latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"
else
  docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"
fi

docker manifest push "smasherofallthings/${IMAGE_NAME}:latest"
