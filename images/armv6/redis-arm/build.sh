#!/bin/sh
export image_name=redis-arm

docker build -t alexellis2/$image_name:v6 .
if [ $? -eq 0 ]; then
  echo ""
  echo "Docker image built"
  echo "Now run docker "'"images"'" to check for \"alexellis2/$image_name:v6\""
fi
