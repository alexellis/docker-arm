#!/bin/bash

echo "Attempting to remove existing container"

docker rm -f consul_x64
echo "Starting new alexellis2/consul container"

docker run -d \
 --name consul_x64 \
 -p 8400:8400 -p 8500:8500 -p 8600:53/udp \
 -p 8301:8301 -p 8302:8302 \
 alexellis2/consul \
 -server -bootstrap

docker port consul_x64
