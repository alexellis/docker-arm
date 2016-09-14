
## Create a Raspberry Pi OTG network

We are going to base these instructions around Rasbpian Jessie light as the OTG host and the OTG guests.

### 1.0 Prepare your Pi Zero

Flash the latest Jessie Lite image to your SD card, then mount the filesystem on a Linux PC or Raspberry Pi.

#### Enable the OTG Kernel modules

We turn on OTG networking through the ether_g / dwc2 modules. These are already present on your image so you just need to update `cmdline.txt` to tell the Kernel how to access them.

In mount partition 1 and edit `/boot/cmdline.txt`

Before

```
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait
```

After

```
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait modules-load=dwc2,g_ether g_ether.host_addr=00:22:82:ff:ff:01 g_ether.dev_addr=00:22:82:ff:ff:11 quiet
```

We added the following after the rootwait instruction:

* g_ether.host_addr=00:22:82:ff:ff:**01**

This is the MAC address of the virtual ethernet adapter on the host computer (Pi 2/ Pi 3)

* g_ether.dev_addr=00:22:82:ff:ff:**11**

This is the MAC address of the virtual ethernet adapter on the guest (Pi Zero)

For each additional Pi Zero you add edit cmdline.txt file and increment 01 to 02, 03 etc and 11 to 12, 13 etc.

*Make sure all instructions are on one line only*

#### Enable the OTG overlay

There is another file we need to edit while we have the boot partition still mounted.

Add this to the end of the `/etc/config.txt` file on two separate lines. The first line enables the OTG overlay. The second line makes slightly more memory available to any services we may want to run such as Docker.

dtoverlay=dwc2
gpu_mem=16

*Unmount the boot partition.*

#### Set the hostname

Now mount the second partition of the SD card and replace *raspberrypi* with *worker1* or *worker2* in `/etc/hosts` and `/etc/hostname`.

*While you are at it, you may as well delete the `/etc/motd` file to make logging in more concise.*

#### Set a static IP address

There are several ways of setting a static IP address.

Append this to the end of `/etc/dhcpcd.conf`

```
interface usb0
static ip_address=10.0.10.2/24
static routers=10.0.10.1
static domain_name_servers=8.8.8.8
```

On each additional Pi change the subnet portion of network address like this:

```
static ip_address=10.0.11.2/24
static routers=10.0.11.1
```

#### Repeat

Now repeat the above steps for each additional Pi Zero you want to connect to the network. You can connect up to four devices to a Pi 2 / Pi 3 through the built-in ports. More may be supported if you use a powered hub.

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


### 3.0 Test connectivity

At this point you should plug in your first Pi Zero and check the output of `dmesg` and `ifconfig` to see when the device has become available.

 
