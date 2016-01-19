#!/bin/bash

export eth0_addr=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

export node_ip=$eth0_addr:2375

export consul_addr=192.168.0.200:8500
export image=alexellis2/swarm-arm

echo "Removing old container"
docker rm -f join

echo "Starting new container"

docker run --name join -d $image join --advertise=$node_ip consul://$consul_addr/swarm
