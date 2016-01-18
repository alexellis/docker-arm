#!/bin/bash

echo "Attempting to remove existing container"

docker rm -f consul
echo "Starting new alexellis2/consul-arm container"

docker run -d \
 --name consul \
 -p 8500:8500 \
 alexellis2/consul-arm \
 -server -bootstrap

docker port consul
