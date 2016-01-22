#!/bin/bash

export DOCKER_HOST=tcp://192.168.0.200:4000

docker rm -f redis_1 redis_2 redis_3 redis_4 redis_5 redis_6 \
redis_7 redis_8 redis_9 redis_10 redis_11 redis_12

docker ps -qa --filter="label=node_redis"|xargs docker rm -f
