#!/bin/bash
export node_ip=192.168.0.x:2333 \
export consul_addr=192.168.0.y:8500
export image=alexellis2/swarm-arm

docker run -d $image join --advertise=$node_ip consul://$consul_addr/swarm
