#!/bin/bash

# Ahead of getting this entirely pipelined up I'm using a quick and dirty build script. This will build each image, tag it appropriately and push it to docker hub.
# I am the smasher of all things and you probably are not so you're likely to get a perms denied if you run it!

scriptDir=$(realpath $(dirname ${0}))

logAndExit() {
  printf "\n\n\e[31m<$(date --rfc-3339=seconds)>\e[0m - ${*}\n"
  exit 1
}

toBuild=("base-image" "debug" "flask-waitress" "certbot-k8s" "solidjs" "python-fe")

if [[ ! -z $1 ]]; then
  toBuild=("${1}")
fi

for f in "${toBuild[@]}" ; do
  printf "\n_____________________________________\n<$(date --rfc-3339=seconds)> - Handling ${f}\n"
  if [[ -d $f ]]; then
    cd $f
    imgName="smasherofallthings/${f##*/}"
    docker build -t $imgName . || logAndExit "Failed to build image ${f}! Exiting..."
    docker push $imgName || logAndExit "Failed to push image ${f}! Exiting..."
    cd ..
  fi
done
