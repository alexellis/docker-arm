docker-arm
=================

Build scripts and sample images for Docker and Docker Swarm on Raspberry PI 2 / ARMv7.

### Commissioning

This repository is to be used along with a tutorial for setting up Docker Swarm on ARM/Raspberry PI. The article will be published in [Linux User and Developer](http://www.linuxuser.co.uk) magazine in late March. For the time being a condensed version of the technical instructions are available here:

[Follow the condensed guide](https://github.com/alexellis/docker-arm/blob/master/GUIDE.md)

#### Just want to build Docker 1.9.1 on ARM?

Would you like to build Docker 1.9.1 on an earlier version of Docker then go to images/docker-arm and run `build.sh`.

*Docker 1.7.1 is available for Arch Linux Arm in `pkg/`.*

![Docker Swarm, originally 5 nodes, now 7](http://blog.alexellis.io/content/images/2015/11/11375892_501978669969619_1957604497_n.jpg)

*My original [blog article](http://blog.alexellis.io/docker-swarm-on-raspberry-pi/).*

### The scripts

The scripts folder provides shortcuts for starting a Docker swarm on the private network space of '192.168.0.0/24'
- Primary node (192.168.0.200)
  - Consul on port 8500
  - Swarm manager on port 4000

- Agent nodes (192.168.0.x)
  - Use script/auto\_join\_swarm.sh

### The images

A number of images are included which run the following software:
- redis-arm
- consul-arm
- swarm-arm
- noderedis4.x node.js 4.x express website linked to redis

Also included are two images to build docker itself and the docker-swarm binary:
- swarm-arm-builder
- docker-arm

#### Running the example from the tutorial

To run the main example from the tutorial, start a number of linked noderedis4.x and redis-arm containers followed by a nginx_dynamic instance in front of it.

```
# docker run -p 6379:6379 -d --name redis_1 alexellis2/redis-arm
# docker run -p 3000:3000 -d \ --label=’node_redis’ \
--link redis_1:redis \
expressredis4.x
```
Repeat above increment redis_1 to redis_2 etc on each node.

Start the nginx container which will query the swarm and then set up a config file for load balancing:
```
# docker run -d --name=balancer -p 80:80 nginx_dynamic
```

Finally use Apache Bench to get some numbers:

```
# ab -n 1000 -c 10 http://192.168.0.200/
...
Concurrency Level:     10
Time taken for tests:  2.593 seconds
Requests per second:   385.65 [#/sec] (mean)
...
```



Copyright Alex Ellis 2016 (@alexellis)
