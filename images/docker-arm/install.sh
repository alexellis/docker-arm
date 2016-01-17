#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo/root"
  exit
fi

if [ ! -f ./docker-1.9/bundles/1.9.1/binary/docker-1.9.1 ]; then
	echo "\"./docker-1.9/bundles/1.9.1/binary/docker-1.9.1\" not found, please run build.sh"
	exit
fi

mkdir -p ./backup

systemctl stop docker

# Backup old version, if it exists
if [ ! -f ./backup/docker-1.7.1 ]; then
	cp /usr/bin/docker ./backup/docker-1.7.1
fi

# Install new version
cp ./docker-1.9/bundles/1.9.1/binary/docker-1.9.1 /usr/bin/docker

if [ ! -f ./docker.service.bak ]; then
	cp /usr/lib/systemd/system/docker.service ./backup/docker.service
fi

cp ./docker.service /usr/lib/systemd/system/docker.service
echo "Running 'systemctl daemon-reload' for you."

systemctl daemon-reload

echo ""
echo "Now run \"sudo systemctl restart docker\" and check the output of \"docker info\""
