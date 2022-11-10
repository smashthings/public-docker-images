#!/bin/bash

set -e

docker build -t smasherofallthings/$1:amd64-latest $1/

