#!/bin/bash

docker build -t alexellis2/swarm-arm-builder .

# -v switch mounts a host volume, so we can extract the swarm binary from the container
mkdir -p binary
docker run -v `pwd`/binary:/tmp/binary alexellis2/swarm-arm-builder /root/export_binary.sh

echo "An ARM compatible swarm binary will now be found in the /binary folder"
