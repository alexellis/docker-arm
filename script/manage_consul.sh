#!/bin/bash

export swarm_ip=192.168.0.x:2376
export consul_addr=192.168.0.y:8500
export image=alexellis2/swarm-arm

docker run -p $image manage -H tcp://$swarm_ip consul://$consul_addr/


