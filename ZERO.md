## Docker Swarm on PI Zero

**Feedback/questions**

Please **Star** the docker-arm repository to show your support. For questions send me a comment on the [blog](http://blog.alexellis.io/dockerswarm-pizero/) and for bugs/problems raise an issue on the repository.

**Overview**

With the release of the 5 dollar PI Zero computer, there has never been a better time to start building a Docker Swarm. Whether you want to try distributed computing or just build something cool with your PI Zeros.

In this quick-start guide we will configure Arch Linux ARM, install Docker and then use a laptop or another PC to create a swarm which all our PI Zeros can join. There are several ways of doing this, but we'll keep things simple and give you the opportunity to take it further later on. I've provided some sample images for Node.js, Redis, Ruby and Python so once you're up and running it's over to you to create something awesome.

* Install & configure Arch Linux ARM
* Install Docker
* Configure a Swarm
* Start the Swarm

You will need:

* Raspberry PI Zero, at least two
* At least one Ethernet adapter
* A computer or Raspberry PI running Linux

### Step 1

#### Raspbian

I would recommend starting with a fresh SD card and Arch Linux, but Rasbpian is also supported with a work-around to enable the latest version of Docker. The version in Jessie's apt repository is going to be out of date.

**Prepare the kernel modules and OS**

Download the latest Hypriot build of Docker, compatible with Jessie:

```
$ wget https://packagecloud.io/Hypriot/Schatzkiste/packages/raspbian/jessie/docker-hypriot_1.11.1-1_armhf.deb/download
```

Now prepare the kernel modules and install extra packages.

```
sudo apt-get update && sudo apt-get install libapparmor1
echo overlay | sudo tee -a /etc/modules
sudo modprobe overlay
sudo dpkg -i docker-hypriot_1.11.1_armhf.deb
```

#### Arch Linux

Arch Linux ARM (aka ALARM) is a minimal Raspberry PI Linux distribution which gives us a great platform to run Docker. It also runs a rolling-release meaning the packages available in its *pacman* software manager are always bleeding-edge.

There is no .img or .iso file available for ALARM, instead we will need another Raspbery PI or Linux computer and an SD card reader where we can partition the card, format it and then un-tar a root filesystem provided by Arch Linux ARM.

Head over to https://archlinuxarm.org/platforms/armv6/raspberry-pi and click the *Installation* tab and follow the instructions.

### Step 2

**Booting and configuring network**

*From this point continue with the steps that will work with either Raspbian or Arch Linux ARM*

Arch Linux ARM does not come with any wi-fi packages pre-installed, but if you have an Ethernet adapter this will automatically connect to your network and obtain an IP address via DHCP. To find the IP address of your PI you can either go to the administration page of your ISP's router or run the `nmap` network scanner.

Example network scan:

```
$ nmap -sP 192.168.0.0/24
...

Found 192.168.0.2

$ ssh alarm@192.168.0.2
```

*Attempt to use SSH to connect to each IP address until you find the PI*

The PI's default username and password are: alarm/alarm and root/root. By default `sudo` is an optional package, which you can install through `pacman`. Pacman is the equivalent to `apt-get` on Raspbian.

Make a note of the IP address of the PI Zero and make sure you change the default passwords immediately.

### Step 4

**Configure Arch**

Install some packages that we will need later on in the tutorial.

```
pacman -Syu sudo cronie git wget
```

Switch to root with `su` and edit the `/etc/sudoers` file in nano or vim.

Uncomment the below starting *# %wheel*

```
## Same thing without a password
# %wheel ALL=(ALL) NOPASSWD: ALL
```

Save the file and now you will be able to use the `sudo` command as the alarm user.

At this point you could also switch over to a wi-fi adapter by installing the `wpa_actiond` package from pacman. This installs the `wifi-menu` program allowing you to configure the SSID and password.

*Pro-tip: you can plug the SD card into a Model B/B+ Raspberry PI to take advantage of its on-board ethernet adapter.*

### Step 3

**Installing Docker**

Installing Docker could not be easier thanks to the hard work of the Arch Linux community. Go ahead and type in the following:

```
pacman -Sy docker
```

Once installed, let's configure Docker.

```
systemctl enable docker
systemctl start docker
sudo usermod alarm -aG docker
```

Please reboot the system. Congratulations, you now have Docker fully working on your PI Zero!

### Step 4

**Enable the Swarm**

Most Docker images are only available for regular PCs (i.e. x64) so for the Raspberry PI we need to use specific versions for the *ARM* architecture. Pull down the Docker swarm image:

```
docker pull alexellis2/swarm-arm:v6
```

Now we will edit the Docker daemon's configuration to allow any computer on our network to control it. Please beware that this setting should only be used within your internal network, if you wanted to use it over the Internet then look into TLS encryption in Docker documentation.

Edit `/usr/lib/systemd/system/docker.service` and on the line `ExecStart` add the following:

```
-H tcp://0.0.0.0:2375
```

Your line will now look a bit like this:

```
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2375 
```

Now reboot the system or reload the configuration with:

```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### Step 6

**Start the Swarm manager**

Now log into either one of your PI Zeros or your PC/laptop.

Take a note of the IP addresses of all the PI Zeros and edit the `--nodes://` parameter below:

i.e.

`--nodes://192.168.0.2:2375`

On a PC:

```
docker run -d --name manage -p 2376:2375 swarm manage nodes://192.168.0.2:2375,192.168.0.3:2375
```


On a PI Zero:

```
$ docker run -d --name manage -p 2376:2375 alexellis2/swarm-arm:v6 manage nodes://192.168.0.2:2375,192.168.0.3:2375
```

To check on the status of the swarm manager:

```
$ docker logs manage
time="2016-04-14T08:20:24Z" level=info msg="Listening for HTTP" addr=":2375" proto=tcp
time="2016-04-14T08:20:26Z" level=info msg="Registered Engine zero1 at 192.168.0.2:2375"
time="2016-04-14T08:20:27Z" level=info msg="Registered Engine zero2 at 192.168.0.3:2375"
```

### Step 7

**Querying the Swarm**

You now have a fully working swarm, to query the swarm as a whole connect to the manager container we just started.

```
export DOCKER_HOST=tcp://localhost:2376
```

Let's find out how many resources we have available:

```
$ docker info
Containers: 6
 Running: 0
 Paused: 0
 Stopped: 0
Images: 23
Role: primary
Strategy: spread
Filters: health, port, dependency, affinity, constraint
Nodes: 2
 zero1: 192.168.0.2:2375
  └ Containers: 1
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 504 MiB
  └ Labels: executiondriver=native-0.2, kernelversion=4.1.21-1-ARCH, operatingsystem=Arch Linux ARM, storagedriver=aufs
 zero2: 192.168.0.3:2375
  └ Containers: 5
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 504 MiB
  └ Labels: executiondriver=native-0.2, kernelversion=4.1.21-1-ARCH, operatingsystem=Arch Linux ARM, storagedriver=aufs
Plugins:
 Volume:
 Network:
CPUs: 2
Total Memory: 1008 MiB
```

So that is 2x CPUs and 1GB of RAM.

### Step 8

**Running a container in the swarm**

```
$ export DOCKER_HOST=tcp://localhost:2376

$ docker pull alexellis2/ruby-arm:v6
$ mkdir -p ruby_hello_world
$ cd ruby_hello_world
```

Add the following main.rb file:

```
who = "Ruby"
puts "Hello #{who}!"
```

Enter the following Dockerfile

```
FROM alexellis2/ruby-arm:v6
ADD ./main.rb ./
CMD ["ruby", "main.rb"]
```

```
$ docker build -t ruby_hello_world:v6 .
$ docker run ruby_hello_world:v6
Hello Ruby!
```

**Spreading images between the Swarm**

The easiest way to spread your images between the Swarm is to push them to the Docker Hub with `docker push` then log into each PI and use `docker pull` to bring it into the local library. If you build an image pointing at the swarm manager then the manager will pick a random PI Zero to do the build.

The alternative method is to log into each PI and build the image from source as we did above.

### Wrapping up

This is the end of the quick-start tutorial. You now have a fully working PI Zero Swarm and are ready to start exploring images built specifically for ARM. Please see the repository `docker-arm` over at Github for compatible ARMv6 images:

[alexellis's ARMv6 Images](https://github.com/alexellis/docker-arm/tree/master/images/armv6)

### See also:

Additional instructions are available for the Raspberry PI 2/3, including how to set up a Swarm using *Consul* for discovery instead of using the hard-coded `nodes://` method.

[Docker for Raspberry PI tutorial](http://blog.alexellis.io/linux-user-developer-magazine/)

[Docker Swarm documentation](https://docs.docker.com/swarm/)


Copyright Alex Ellis 2016
