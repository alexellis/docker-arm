
## Create a Raspberry Pi OTG network

We are going to base these instructions around Rasbpian Jessie light as the OTG host (I've tested with a Pi3) and the OTG guests (Pi Zeros). If you find this guide helpful, please click the **Star** button.

Check out the accompanying blog post for this guide:

* [Build your PiZero Swarm with OTG networking](http://blog.alexellis.io/pizero-otg-swarm/)

### 1.0 Prepare your Pi Zeros

* Flash the Jessie Lite image to your SD card.

* Boot up the Pi Zero and shut it down again - this lets Raspbian resize the filesystem.

#### Enable the OTG Kernel modules

We turn on OTG networking through the ether_g / dwc2 modules. These are already present on your image so you just need to update `cmdline.txt` to tell the Kernel how to access them.

Mount partition 1 and edit `/boot/cmdline.txt`

We need to add the following after the rootwait instruction:

* `g_ether.host_addr=00:22:82:ff:ff:**01**`

This is the MAC address of the virtual ethernet adapter on the host computer (Pi 2/ Pi 3)

* `g_ether.dev_addr=00:22:82:ff:ff:**11**`

This is the MAC address of the virtual ethernet adapter on the guest (Pi Zero)

For each additional Pi Zero you add edit `cmdline.txt` file and increment both numbers: i.e.

* `01` becomes `02`
 * `g_ether.host_addr=00:22:82:ff:ff:**02**`

* `11` becomes `12`
 * `g_ether.dev_addr=00:22:82:ff:ff:**12**`

*When you save the file, make sure all instructions are on one line only*

Before:

```
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait
```

After:

```
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait modules-load=dwc2,g_ether g_ether.host_addr=00:22:82:ff:ff:01 g_ether.dev_addr=00:22:82:ff:ff:11 quiet
```

#### Enable the OTG overlay

There is another file we need to edit while we have the boot partition still mounted.

Add this to the end of the `/etc/config.txt` file on two separate lines. The first line enables the OTG overlay. The second line makes slightly more memory available to any services we may want to run such as Docker.

```
dtoverlay=dwc2
gpu_mem=16
```

*Now unmount the boot partition.*

#### Set the hostname

Now mount the second partition of the SD card and replace *raspberrypi* with *worker1* or *worker2* in `/etc/hosts` and `/etc/hostname`.

*While you are at it you can also remove the login message with `rf -rf /etc/motd`, or replace it with your own message.*

#### Set a static IP address

There are several ways of setting a static IP address - I initially spent time trying to use `systemd` but `dhcpcd` was still overriding the values. I would suggest you follow the guide and tweak afterwards once you have everything working.

Append this to the end of `/etc/dhcpcd.conf`

```
interface usb0
static ip_address=10.0.11.2/24
static routers=10.0.11.1
static domain_name_servers=8.8.8.8
```

On each additional Pi change the subnet portion of network address like this:

```
static ip_address=10.0.12.2/24
static routers=10.0.12.1
```

#### Repeat

Now repeat the above steps for each additional Pi Zero you want to connect to the network. You can connect up to four devices to a Pi 2 / Pi 3 through the built-in ports. Sometimes adding power to each Pi Zero can increase reliability.

>  I have not had success with a powered hub, but your mileage may vary.

### 2.0 Configure the host

For the host's configuration we need to set a static IP address for each USB connection plugged in and to make sure that each Pi gets the same address each time we'll set up a UDEV rule.

#### Enable IP forwarding

IP forwarding enables us to access the local network of the host and your home router etc.

```
sysctl -w net.ipv4.ip_forward=1
```

#### Add UDEV rules

Edit `/etc/udev/rules.d/90-pi-network.rules`

```
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:01", NAME="ethusb1"
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:02", NAME="ethusb2"
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:03", NAME="ethusb3"
```

When the Pi with address `00:22:82:ff:ff:01` is plugged in it may get any name such as usb0, usb1, usb2 etc so these rules make a static assignment to ethusb1. The Pi Zero with the following address with be assigned the device name ethusb2 etc.

#### Create static IP addresses on the host

Each end of the USB cable ends up having a separate IP address used to address either the host from the Pi Zero or the Pi Zero from the host.

Edit `/etc/dhcpcd.conf` and add an entry for each adapter.

i.e.

```
interface ethusb1
static ip_address=10.0.11.1/24
static domain_name_servers=8.8.8.8
```

```
interface ethusb2
static ip_address=10.0.12.1/24
static domain_name_servers=8.8.8.8
```

### 2.1 Routing

You may want to enable your Pi Zeros to reach the Internet, if that is the case then the following `iptables` rules worked for me. There may be a better way of doing this, but it will get you started:

```
$ iptables -t nat -A POSTROUTING ! -d 10.0.11.0/24 -o eth0 -j MASQUERADE
$ iptables -t nat -A POSTROUTING ! -d 10.0.12.0/24 -o eth0 -j MASQUERADE
$ iptables -t nat -A POSTROUTING ! -d 10.0.13.0/24 -o eth0 -j MASQUERADE
```

### 2.2 Test connectivity

At this point you should plug in your first Pi Zero and check the output of `dmesg` and `ifconfig` to see when the device has become available.

### 3.0 Install Docker and create a cluster

To install Docker on each Pi Zero follow the guide here:

[Get started with Docker on the Pi](http://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/)

To configure your swarm log into the host and type in `docker swarm init`. This will create a join token that can be passed into each of your Pi Zeros over SSH. Once you have joined each of your Pi Zeros use the `docker node ls` command to view the list of connected nodes.

Finally, follow the [Docker Swarm Mode on the Pi](http://blog.alexellis.io/live-deep-dive-pi-swarm/) to start tasking your super computer.

I also have a set of [Swarm Mode tests](https://github.com/alexellis/swarmmode-tests/tree/master/arm) that you can run through to check that everything's OK. And if you are running into trouble then a reboot does normally help resolve OTG issues for me.

**Super quick test (enter instructions on the host)**

This creates a micro-service which generates a GUID and also returns the container ID that generated it. You can use this to track down which Pi generated the GUID.

```
$ docker network create --driver overlay --subnet 20.0.12.0/24 armnet
$ docker service create --network armnet --replicas=5 --name guid -p 9000:9000 alexellis2/guid-generator-arm:0.1
```

Check the output of `docker service ps guid` until you see all the tasks are started.

Now hit the endpoint:

```
$ curl -4 localhost:9000/guid
```

Install Apache Bench (apache-utils) and then generate some load:

100 requests, 1 concurrently:

```
$ ab -n 100 -c 1 http://localhost:9000/guid

Time taken for tests:   1.186 seconds
Requests per second:    84.32 [#/sec] (mean)
```

100 requests, 5 concurrently:

```
$ ab -n 100 -c 5 http://localhost:9000/guid

Time taken for tests:   0.312 seconds
Requests per second:    320.91 [#/sec] (mean)
```

### Feedback

If you find this guide helpful, please click the **Star** button.

#### Got problems?

Please get in touch on Twitter [@alexellisuk](https://twitter.com/alexellisuk) or through the blog post.

#### Want to make a PR?

Feedback is welcome, so please raise an issue so we can discuss the change.
