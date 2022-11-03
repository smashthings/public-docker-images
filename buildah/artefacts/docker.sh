#!/bin/bash

if [[ $1 == "build" ]]; then
  shift 1
  eval buildah bud "$@"
else
  eval buildah "$@"
fi