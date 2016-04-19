#!/bin/bash

# This script is designed to be run on a 'regular' x64 machine
# rather than a Raspberry PI itself.

export primary_node=35
export manage_port=2376
export swarm_ip=192.168.0.$primary_node
export consul_addr=192.168.0.$primary_node:8500

export image_name=swarm

echo "Removing old manage_x64 container"
docker rm -f manage_x64

echo "Starting new manage_x64 container"

echo "Using version: $swarm_version"
export image=swarm

docker run -d -p 2376:2375 --name manage_x64 $image_name manage \
consul://$consul_addr/swarm
