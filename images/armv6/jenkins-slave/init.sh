#!/bin/bash

#sudo /usr/bin/docker daemon -H fd:// &
sudo /usr/bin/docker daemon &

sudo /usr/sbin/sshd -D

