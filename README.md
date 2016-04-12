docker-arm
=================

Build Docker, Swarm and native images for the Raspberry PI 2/3 and ARMv7 Architecture.


![Docker Swarm, originally 5 nodes, now 7](http://blog.alexellis.io/content/images/2016/03/12751465_202678110091142_997768928_n.jpg)

### Commissioning

This repository was commissioned to support a tutorial published in [Linux User and Developer](http://www.linuxuser.co.uk) issue 163 March 2016.

[Issue 163 of Linux User and Developer Magazine](https://www.imagineshop.co.uk/magazines/linuxuser/linux-user-and-developer-issue-163.html)

In the article I outline the case for Docker Swarm on the Raspberry PI and into detail on how to recompile the latest version of Docker from an older (issue-free) version. We then build Docker Swarm itself and go on to build out some test images for Node.js, Redis and Consul. Finally we put it all together and use Apache-Bench to load-test the solution with Nginx doing load-balancing for us.

I have provided a much condensed and abbreviated version of the steps in this guide:

[Follow the condensed guide](https://github.com/alexellis/docker-arm/blob/master/GUIDE.md)

#### The blog entry

Read more about writing for Linux User and Developer magazine on my [blog article](http://blog.alexellis.io/linux-user-developer-magazine/).

#### TLDR; Just want to build Docker 1.9.1 on ARM?

Would you like to build Docker 1.9.1? Then we can make use of a stable 1.7.1 version for that purpose, clone this repository and then go into images/docker-arm and execute `build.sh`. This will produce a fully-compatible with ARM statically-linked binary to use as per the official Docker documentation.

*Docker 1.7.1 is available for Arch Linux Arm in `pkg/`.*

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
