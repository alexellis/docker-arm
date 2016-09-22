#!/bin/bash

docker service rm kitties

docker service create --mount type=bind,source=/etc/hostname,target=/etc/host.hostname \
 --name kitties --replicas=4 --network armnet \
 --publish 5000:5000 \
 alexellis2/kittens-armhf:latest
