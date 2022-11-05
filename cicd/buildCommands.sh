#!/bin/bash

set -e

docker build -t "smasherofallthings/${IMAGE_NAME}:amd64-latest" -t "smasherofallthings/${IMAGE_NAME}:amd64-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" "${IMAGE_NAME}/"

docker buildx build -t "smasherofallthings/${IMAGE_NAME}:arm7-latest" -t "smasherofallthings/${IMAGE_NAME}:arm7-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" -f "${IMAGE_NAME}/${ArmDockerfile:-Dockerfile}" --platform linux/arm/v7 --output type=docker "${IMAGE_NAME}"

for f in 'amd64-latest' 'arm7-latest' "amd64-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}" "arm7-$(date '+%Y-%m-%d')-b${DRONE_BUILD_NUMBER}";
  do printf "Pushing $f\n" && docker push "smasherofallthings/${IMAGE_NAME}:${f}"
done

docker manifest create "smasherofallthings/${IMAGE_NAME}:latest" --amend "smasherofallthings/${IMAGE_NAME}:arm7-latest" --amend "smasherofallthings/$IMAGE_NAME:amd64-latest"

docker manifest push "smasherofallthings/${IMAGE_NAME}:latest"
