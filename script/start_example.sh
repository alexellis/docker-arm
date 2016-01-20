#!/bin/bash

# Example starts 6 redis instances, binding to port 6379 on the host
# forces each one to a specific PI.
#
# We then link expressredis4.x to a redis instances, meaning it is 
# also one per PI.
#
# Nginx then looks for the label node_redis to build up its servers
# list and will balance requests across each PI.

export DOCKER_HOST=tcp://192.168.0.200:4000

docker run -p 6379:6379 -d --name redis_1 alexellis2/redis-arm
docker run -p 6379:6379 -d --name redis_2 alexellis2/redis-arm
docker run -p 6379:6379 -d --name redis_3 alexellis2/redis-arm
docker run -p 6379:6379 -d --name redis_4 alexellis2/redis-arm
docker run -p 6379:6379 -d --name redis_5 alexellis2/redis-arm
docker run -p 6379:6379 -d --name redis_6 alexellis2/redis-arm

docker run --link redis_1:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x
docker run --link redis_2:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x
docker run --link redis_3:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x
docker run --link redis_4:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x
docker run --link redis_5:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x
docker run --link redis_6:redis -p 3000:3000 -d --label='node_redis'\
 expressredis4.x

