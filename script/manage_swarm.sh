#!/bin/bash

export primary_node=200
export manage_port=4000
export swarm_ip=192.168.0.$primary_node
export consul_addr=192.168.0.$primary_node:8500

export image_name=alexellis2/swarm-arm

echo "Removing old manage container"
docker rm -f manage

echo "Starting new manage container"
if [[ -z $swarm_version ]]; then
        export swarm_version="latest"
fi;

echo "Using version: $swarm_version"
export image=alexellis2/swarm-arm:$swarm_version

docker run -d -p 4000:2375 --name manage $image_name manage \
consul://$consul_addr/swarm
