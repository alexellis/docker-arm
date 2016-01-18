#!/bin/bash

echo "Attempting to remove existing container"

docker rm -f consul
echo "Starting new alexellis2/consul-arm container"

docker run -d \
 --name consul \
 -p 8400:8400 -p 8500:8500 -p 8600:53/udp \
 -p 8301:8301 -p 8302:8302 \
 alexellis2/consul-arm \
 -server -bootstrap

docker port consul
