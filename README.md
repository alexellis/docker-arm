Docker on ARM
=================

After a lot of hard work it became official and Docker came to the Raspberry Pi.

In this repository you will find:

* a curated list of links for getting started with Docker on Pi
* tutorials around Swarm and Swarm Mode
* ARM specific images to get you up and running in no time.

If you've not read the Raspberry Pi blog post then you can see it here:

* [Docker comes to the Raspberry Pi](https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/)

![Getting up close and personal with Docker Swarm Mode](https://pbs.twimg.com/media/CrVYYJxUIAAyuuk.jpg)

### Feedback & questions

I'm a [Docker Captain](http://blog.alexellis.io/follow-all-captains/) so I'd love to hear from you with your questions, comments and suggestions on Twitter [@alexellisuk](https://twitter.com/alexellisuk) or through the blog comments sections.

### License & contributions

This content is licensed under GPLv3. Contributions to keep Dockerfiles up to date and relevant are welcome - also happy to extend the coverage and take updates to the guides. Please just raise an issue before the PR for discussion.

# Lead articles

Since I started this repository the installation of Docker and its native clustering modes has changed. This section gives you a summary of tutorials for each part.  

## Getting started with Docker on the Pi

If you want to see what Docker can do on the Pi, or just want to learn about it then head over to this guide:

* [Get Started with Docker 1.12 on Raspberry Pi](http://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/)

## New Swarm Mode

![Docker Swarm, originally 5 nodes, now 7](http://blog.alexellis.io/content/images/2016/03/12751465_202678110091142_997768928_n.jpg)

Check out my video where I set up a swarm with 7 different Raspbery Pi 2s and demo the Swarm Visualizer project.

* [Live Deep Dive video of Swarm Mode](http://blog.alexellis.io/live-deep-dive-pi-swarm/)

For an overview of Swarm Mode:

* [Scale a real microservice with Docker 1.12 Swarm Mode](http://blog.alexellis.io/docker-swarm-mode-part1/)
* [Learn Docker Swarm Mode - scale in 5 minutes!](http://blog.alexellis.io/microservice-swarm-mode/)

Mano Marks put together a ReactJS [Swarm Visualizer tool](https://github.com/ManoMarks/docker-swarm-visualizer). It was originally demoed at Dockercon over three huge screens. He's accepting contributions so this is a great chance to pitch in.

* [Swarm Visualizer](https://github.com/ManoMarks/docker-swarm-visualizer)

## OTG networking for Raspberry Pi

Set up Swarm Mode with OTG networking, look ma, no ethernet!

* [Build your PiZero Swarm with OTG networking](http://blog.alexellis.io/pizero-otg-swarm/)

## Physical Hardware and GPIO

One of the most exciting ways Docker and the Raspberry Pi work together is through GPIO. You can access hardware such as the products by [Pimoroni](https://shop.pimoroni.com) through containers and build/ship/run/deploy your apps.

For a prime example see my Dockercon 2016 Demo of a set of IoT sensors:

* [Dockercon Speaker notes and demo overview](http://blog.alexellis.io/dockercon-2016-speaker-notes/)

### Classic Docker Swarm

Up until Dockercon 2016 the Docker-way to create a swarm was through a special Docker image called `swarm`. This repository was commissioned to support a tutorial published in [Issue 163 of Linux User and Developer Magazine](https://www.imagineshop.co.uk/magazines/linuxuser/linux-user-and-developer-issue-163.html). If you didn't get a copy of the magazine, you can pick up a digital edition or follow a simplified online guide.

![Published print article](http://blog.alexellis.io/content/images/2016/03/magazine_thumbnail.png)

This article was retweeted by @Docker on Mar 31 2016, so head over to the blog and have a read.

* [Docker Swarm in Linux User Magazine](http://blog.alexellis.io/linux-user-developer-magazine/)

Follow this quick-start guide to get Docker and/or Swarm up and running on your PI Zeros right away.

* [Quick-start Docker/Swarm on PI Zero Tutorial](ZERO.md)

# ARM specific images

If you want to try Docker or Docker Swarm on ARM or are already using it, then you will find these resources useful:

* `/images`

No official Docker images work on the ARM architecture because they contain binaries built for x64 (regular PCs). I've curated separate images for PI 2/3 and PI Zero. You can read more about this in the [Getting Started Tutorial](http://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/)

* Nginx
* Go 1.5
* Go 1.6
* Consul
* Redis
* Node.js 4.x
* Several examples of GPIO
* Build Docker itself

Contributions are welcome, please open an issue with your suggestion and once confirmed I'll be happy to merge the changes. You can also find a number of additional images maintained by the [Hypriot team](https://twitter.com/hypriottweets).

### Looking for the old README for this repo?

Head over to [README_CLASSIC.md](https://github.com/alexellis/docker-arm/blob/master/README_CLASSIC.md)


Copyright Alex Ellis 2016
