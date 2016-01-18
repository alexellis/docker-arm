#!/bin/bash

export node=201

export node_ip=192.168.0.$node:2375

export consul_addr=192.168.0.200:8500
export image=alexellis2/swarm-arm

echo "Removing old container"
docker rm -f join

echo "Starting new container"

docker run --name join -d $image join --advertise=$node_ip consul://$consul_addr/swarm

