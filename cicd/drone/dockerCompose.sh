#!/bin/bash

set -e

hr='===================================================='

if [[ -z $IMAGE_NAME ]]; then
  printf "${hr}\nThe name of the base image must be provided via the environment variable IMAGE_NAME!\n"
  exit 1
fi

if [[ -z $DRONE_BUILD_NUMBER ]]; then
  printf "${hr}\nA build number for this build must be provided under the environment variable DRONE_BUILD_NUMBER!\n"
  exit 1
fi

printf "${hr}\nBeginning build for ${IMAGE_NAME}...\n"
cd "${IMAGE_NAME}"

printf "${hr}\nBuilding x86 with build tag...\n"
Tag="$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" docker compose build amd64
printf "${hr}\nPushing x86 build tag...\n"
Tag="$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" docker compose push amd64
printf "${hr}\nBuilding x86 latest...\n"
docker compose build amd64
printf "${hr}\nPushing x86 latest...\n"
docker compose push amd64

printf "${hr}\nCreating singular manifest for latest...\n"
docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"

printf "${hr}\nPushing manifest...\n"
docker manifest push "smasherofallthings/${IMAGE_NAME}:latest"
printf "${hr}\nBuild Complete!\n"
