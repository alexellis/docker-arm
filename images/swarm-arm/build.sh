#!/bin/sh

docker build -t alexellis2/swarm-arm .
if [ $? -eq 0 ]; then
  echo ""
  echo "Docker image built"
  echo "Now run docker "'"images"'" to check for "'"alexellis2/swarm-arm"'""
fi
