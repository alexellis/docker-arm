Create an Arch Linux OTG cluster with Raspberry Pi
--------------------------------------------------

The default OS for the Raspberry Pi is Raspbian although others are available such as Ubuntu Mate, Risc OS and Arch Linux ARM (ALARM).

> This guide sets out to create an OTG USB network cluster with Arch Linux on ARM.

### On each Pi Zero

* Set up cmdline.txt on Pi 1

```
root=/dev/mmcblk0p2 rw rootwait rootwait modules-load=dwc2,g_ether g_ether.host_addr=00:22:82:ff:ff:01 g_ether.dev_addr=00:22:82:ff:ff:11 console=ttyAMA0,115200 console=tty1 selinux=0 plymouth.enable=0 smsc95xx.turbo_mode=N dwc_otg.lpm_enable=0 kgdboc=ttyAMA0,115200 elevator=noop
```

I've chosen to change the g_ether.host_addr and g_etehr.dev_addr by incrementing the value by 1. These are hexidecimal values. 


* Set up config.txt

```
dtoverlay=dwc2
gpu_mem=16
```

We can turn down GPU memory because we do not need an XServer or console.

* Set up a static IP address with systemd

Create file: `/etc/systemd/network/usb0.network`

```
[Match]
Name=usb0

[Network]
Address=10.0.11.2/24
```

On each additional Pi change the network like:

```
Address=10.0.11.2/24
```

```
Address=10.0.12.2/24
```

```
Address=10.0.13.2/24
```

```
Address=10.0.14.2/24
```

* Set the time (roughly)

```
$ date -s "08/13/2016 6:04pm"
Sat Aug 13 18:04:00 UTC 2016
```

In its initial state the device may not have connectivity and will have an incorrect date. This can be resolved once connectivity is enabled below.

* Enable routing between Pi Zeros

On Pi #1

```
$ ip route add 0/0 via 10.0.11.1 dev usb0
```

On Pi #2

```
$ ip route add 0/0 via 10.0.12.1 dev usb0
```

On Pi #3

```
$ ip route add 0/0 via 10.0.13.1 dev usb0
```

* Optional

Install core packages such as `screen` and `sudo`.

```
$ pacman -Syu screen sudo
```

### On the Pi Host

* Set up UDEV rules

Edit `/etc/udev/rules.d/90-pi-network.rules`

```
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:01", NAME="ethpi1"
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:02", NAME="ethpi2"
SUBSYSTEM=="net", ATTR{address}=="00:22:82:ff:ff:03", NAME="ethpi3"
```

* Set static IP addresses for the new adapters

Under `/etc/systemd/network/` create a new file for each adapter:

ethpi1.network

```
[Match]
Name=ethpi1

[Network]
Address=10.0.11.1/24
```

ethpi2.network

```
[Match]
Name=ethpi2

[Network]
Address=10.0.12.1/24
```

* Internet Connection Sharing

```
[alarm@manager ~]$ sudo iptables -t nat -A POSTROUTING ! -d 10.0.11.0/24 -o eth0 -j MASQUERADE
[alarm@manager ~]$ sudo iptables -t nat -A POSTROUTING ! -d 10.0.11.0/24 -o ethpi1 -j MASQUERADE
```

### Checking the config

`ifconfig` will show the two new network adapters with their IP addresses.

```
ethpi1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.11.1  netmask 255.255.255.0  broadcast 10.0.11.255
        inet6 fe80::222:82ff:feff:ff01  prefixlen 64  scopeid 0x20<link>
        ether 00:22:82:ff:ff:01  txqueuelen 1000  (Ethernet)
        RX packets 43620  bytes 2924608 (2.7 MiB)
        RX errors 1  dropped 0  overruns 0  frame 0
        TX packets 181142  bytes 260684609 (248.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ethpi2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.12.1  netmask 255.255.255.0  broadcast 10.0.12.255
        inet6 fe80::222:82ff:feff:ff02  prefixlen 64  scopeid 0x20<link>
        ether 00:22:82:ff:ff:02  txqueuelen 1000  (Ethernet)
        RX packets 25  bytes 1922 (1.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 32  bytes 3988 (3.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

### Test connectivity

* Check reachability first with `ping`, then with `ssh`.

```
ping -c 3 10.0.11.2
ping -c 3 10.0.12.2
```

You should have `0% packet loss`.

* Check SSH

```
[alarm@manager]$ ssh 10.0.11.2
alarm@10.0.11.2's password:

Welcome to Arch Linux ARM

     Website: http://archlinuxarm.org
       Forum: http://archlinuxarm.org/forum
         IRC: #archlinux-arm on irc.Freenode.net
Last login: Fri Aug 12 09:11:37 2016 from 10.0.11.1
[alarm@worker1 ~]$

[alarm@manager]$ ssh 10.0.12.2
alarm@10.0.12.2's password:
Welcome to Arch Linux ARM

     Website: http://archlinuxarm.org
       Forum: http://archlinuxarm.org/forum
         IRC: #archlinux-arm on irc.Freenode.net
Last login: Sat Jun 25 19:06:34 2016 from 10.0.12.1
[alarm@worker2 ~]$
```

