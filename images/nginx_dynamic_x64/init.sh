#!/bin/sh

node app.js > ~/servers.txt
cat ~/servers.txt
cd /etc/nginx/
sed -i '/upstream node_servers {/r /root/servers.txt' nginx.conf
cat nginx.conf

/usr/sbin/nginx
