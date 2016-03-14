#!/bin/sh

docker build -t alexellis2/swarm-arm:v6 .
if [ $? -eq 0 ]; then
  echo ""
  echo "Docker image built"
  echo "Now run docker "'"images"'" to check for "'"alexellis2/swarm-arm:v6"'""
fi
