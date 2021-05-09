#!/bin/bash

# Ahead of getting this entirely pipelined up I'm using a quick and dirty build script. This will build each image, tag it appropriately and push it to docker hub.
# I am the smasher of all things and you probably are not so you're likely to get a perms denied if you run it!

scriptDir=$(realpath $(dirname ${0}))

logAndExit() {
  printf "\n\n\e[31m<$(date --rfc-3339=seconds)>\e[0m - ${*}\n"
  exit 1
}

docker login

for f in "base-image" "debug" "flask-waitress" ; do
  if [[ -d $f ]]; then
    cd $f
    imgName="smasherofallthings/${f##*/}"
    docker build -t $imgName . || logAndExit "Failed to build image ${f}! Exiting..."
    docker push $imgName || logAndExit "Failed to push image ${f}! Exiting..."
    cd ..
  fi
done
