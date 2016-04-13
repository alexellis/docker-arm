Docker on ARM
=================

**Build Docker, Swarm and native images for the Raspberry PI 2/3 and ARMv7 Architecture. Now featuring PI Zero instructions (ARMv6).**

This repository was commissioned to support a tutorial published in [Issue 163 of Linux User and Developer Magazine](https://www.imagineshop.co.uk/magazines/linuxuser/linux-user-and-developer-issue-163.html). If you didn't get a copy of the magazine, you can pick up a digital edition or follow a simplified online guide.

![Docker Swarm, originally 5 nodes, now 7](http://blog.alexellis.io/content/images/2016/03/12751465_202678110091142_997768928_n.jpg)

### If you are following the Linux Developer and User tutorial

####[Magazine tutorial](LUD.md)

I make the case for Docker Swarm on the Raspberry PI. We walk through fully configuring Arch Linux ARM, we install Docker, then rebuild it from the latest source. Then we go on to build specific images for ARM: Swarm, Consul, Redis, Node.js etc. Then we starting the Swarm, check the nodes and run a distributed web application with a load-balancer.

### Read all about it on the blog

![Published print article](http://blog.alexellis.io/content/images/2016/03/magazine_thumbnail.png)

This article was retweeted by @Docker on Mar 31 2016, so head over to the blog and have a read.


#### [Read the blog post](http://blog.alexellis.io/linux-user-developer-magazine/)


### What else is here?

If you want to try Docker or Docker Swarm on ARM or are already using it, then you will find these resources useful:

* `/images`

No official Docker images work on the ARM architecture because they contain binaries built for x64 (regular PCs). I've curated separate images for PI 2/3 and PI Zero:

* Nginx
* Go 1.5
* Consul
* Building Swarm itself
* Building Docker itself
* Redis
* Node.js 4.x


* `/script`

Here you find a list of scripts used in the magazine tutorial to quickly set up a full Docker Swarm on Raspberry PI using `consul` as the discovery service.

See for instance: `auto_join_swarm.sh` and `start_consul.sh`

* `/pkg`

When this tutorial was first published there was no working package available in the Arch Linux ARM (ALARM) repository for Docker, so you can find Docker 1.7.1 here which at the time was used to build the latest from Github.

### Feedback & Questions

Please leave comments and questions over on my blog at:

#### [Blog post](http://blog.alexellis.io/linux-user-developer-magazine/)

If you are running into issues with the scripts or images, then raise an issue on the Github repository.


Copyright Alex Ellis 2016 (@alexellis)
