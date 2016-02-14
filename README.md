docker-arm
=================

Build scripts and sample images for Raspberry PI 2 / ARM.

### Purpose

This repository is to be used along with a tutorial for setting up Docker Swarm on ARM/Raspberry PI. More details to come when article is published.

#### Just want to build Docker 1.9.1 on ARM?

Would you like to build Docker 1.9.1 on an earlier version of Docker then go to images/docker-arm and run `build.sh`.

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


Copyright Alex Ellis 2016 (@alexellis)
