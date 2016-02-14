#!/bin/bash

export eth0_addr=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
export node_ip=$eth0_addr:2375
export consul_addr=192.168.0.200:8500

echo "Removing old container"
docker rm -f join

if [[ -z $swarm_version ]]; then
        export swarm_version="latest"
fi;

echo "Using version: $swarm_version"
export image=alexellis2/swarm-arm:$swarm_version

echo "Starting new container"

docker run --name join -d $image join --advertise=$node_ip consul://$consul_addr/swarm
