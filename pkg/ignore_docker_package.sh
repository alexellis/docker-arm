#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo/root"
  exit
fi

echo "Altering /etc/pacman.conf to set \"IgnorePkg = docker\""
sed -i s/'#IgnorePkg   ='/'IgnorePkg   = docker'/g /etc/pacman.conf

echo "Done."
