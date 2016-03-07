## The abbreviated guide

This repository accompanies a tutorial commissioned by Linux User and Developer magazine.

I am providing an abbreviated guide of the instructions for advanced users - this assumes you have already set up Arch Linux and provided a static IP address. You can also use this

* Install Linux tools and utilities

```
# pacman -Syu --noconfirm base-devel wget git sudo screen bridge-utils device-mapper apache
```

* Clone the repo

```
# cd ~
# git clone http://github.com/alexellis/docker-arm/
```

* Install previous version of Docker

```
# sudo pacman -U ~/docker-arm/pkg/docker-1:1.7.1-2- armv7h.pkg.tar.xz --noconfirm
# sudo cp ~/docker-arm/pkg/docker.service /usr/ lib/systemd/system/docker.service
# sudo systemctl enable docker
# sudo systemctl start docker
# sudo usermod lud -aG docker # sudo reboot
# sudo ~/docker-arm/pkg/ignore_docker_package.sh
```

* Build Docker 1.9 on Docker

```
# cd ~/docker-arm/images/docker-arm # ./build.sh
```

* Install Docker 1.9

```
# cd ~/docker-arm/images/docker-arm # sudo ./install.sh
# sudo systemctl start docker
```

* Build the Docker swarm image

```
# cd ~/docker-arm/images/swarm-arm
# ./build.sh
# docker run alexellis2/swarm-arm --version
```

* Start the primary node

Run this on the primary node using IP address 192.168.0.200 (or edit the scripts)

```
# cd ~/docker-arm/images/consul-arm
# ./build.sh
# ~/docker-arm/script/start_consul.sh
# ~/docker-arm/script/manage_swarm.sh
```

* Join each node to the swarm

Log into each node, and if necessary edit the IP address of the primary node, which is 192.168.0.200 by default.

```
# ~/docker-arm/script/auto_join_swarm.sh
```

* Query the swarm
```
# docker run alexellis2/swarm-arm list consul://192.168.0.200:8500/swarm
```

Example output:

```
192.168.0.201:2375
192.168.0.202:2375
192.168.0.203:2375
192.168.0.204:2375
192.168.0.210:2375
```

* Point a Docker client to the swarm

```
export DOCKER_HOST=tcp://192.168.0.200:4000
```

Then run any Docker command as per usual.
