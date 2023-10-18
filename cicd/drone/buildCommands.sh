#!/bin/bash

set -e

allBuilds=()
allBuilds+=('amd64-latest')
allBuilds+=("amd64-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}")

if [[ ! -z $SkipArmBuild ]] && [[ $SkipArmBuild == "true" ]]; then
  printf "Skipping arm builds"
else
  allBuilds+=('arm7-latest')
  allBuilds+=("arm7-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}")
fi

docker build -t "smasherofallthings/${IMAGE_NAME}:amd64-latest" -t "smasherofallthings/${IMAGE_NAME}:amd64-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" "${IMAGE_NAME}/"

if [[ -z $SkipArmBuild ]]; then
  docker buildx build -t "smasherofallthings/${IMAGE_NAME}:arm7-latest" -t "smasherofallthings/${IMAGE_NAME}:arm7-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" -f "${IMAGE_NAME}/${ArmDockerfile:-Dockerfile}" --platform linux/arm/v7 --output type=docker "${IMAGE_NAME}"
fi

for f in "${allBuilds[@]}"; do
  printf "Pushing $f\n" && docker push "smasherofallthings/${IMAGE_NAME}:${f}"
done

if [[ -z $SkipArmBuild ]]; then
  docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/${IMAGE_NAME}:arm7-latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"
else
  docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"
fi

docker manifest push "smasherofallthings/${IMAGE_NAME}:latest"
