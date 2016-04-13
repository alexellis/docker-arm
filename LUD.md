### Welcome from Linux Developer & User

This repository was commissioned to support a tutorial published in [Issue 163 of Linux User and Developer Magazine](https://www.imagineshop.co.uk/magazines/linuxuser/linux-user-and-developer-issue-163.html).

In the article I outline the case for Docker Swarm on the Raspberry PI and..

* Install and configure Arch Linux giving a static IP address

* Go into detail on how to recompile the latest version of Docker from an older (issue-free) version

**Updates for Step 7 & 8**

Please skip both of these steps and run the below instead (this is because Docker 1.10-3 is fully working in the package repository)

07 Install Docker 1.7.1
08 Build Docker on Docker!

```
# pacman -Sy docker
# sudo systemctl enable docker
# sudo usermod lud -aG docker
# sudo reboot
```

Edit `/usr/lib/systemd/system/docker.service` and add the following to the line starting `ExecStart` to:

```
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2375 --cluster-advertise eth0:2375 --cluster-store consul://192.168.0.35:8500
```

* We then build Docker Swarm itself

* Build out native images for Node.js, Redis and Consul.

Finally we put it all together and use Apache-Bench to load-test the solution with Nginx doing load-balancing for us.

I have provided a much condensed and abbreviated version of the steps in this guide: [Follow the condensed guide](https://github.com/alexellis/docker-arm/blob/master/GUIDE.md)

> ### Feedback & Questions

Please leave comments and questions over on my blog at:

#### [Blog post](http://blog.alexellis.io/linux-user-developer-magazine/)

If you are running into issues with the scripts or images, then raise an issue on the Github repository.
