#!/bin/bash

# Taken from https://gist.github.com/djmaze/8c63d0ff2ef74e8db9fb
# Brings some arm specific files from 1.10-dev back into 1.9.1 branch/tag
#wget \
#https://gist.githubusercontent.com/djmaze/8c63d0ff2ef74e8db9fb/raw/ca2c7bc2d67a041d42b43fd3854ca8a882f89b32/build-1.9-on-arm.sh

./build-1.9-on-arm.sh
cd docker-1.9
sed -i 's/export DOCKERFILE/export DOCKERFILE=Dockerfile.armhf/' Makefile
make binary


