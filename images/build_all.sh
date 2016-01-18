#!/bin/sh

function build {
	echo "Entering $1"
	echo "Building $1/Dockerfile"
	cd $1
	./build.sh
	cd ..
	echo
}

images=(
  'consul-arm'
#  'docker-arm' # we have already done this
  'redis-arm'
  'swarm-arm'
)

for project in "${images[@]}"
do
    build $project
done

