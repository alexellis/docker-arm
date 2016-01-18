#!/bin/sh

function build {
	echo "Entering $1"
	echo "Building $1/Dockerfile"
	cd $1
	./build.sh
	echo
}

images=(
  'consul-arm'
  'docker-arm'
  'redis-arm'
  'swarm-arm'
)

for project in "${images[@]}"
do
    build $project
done

