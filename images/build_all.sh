#!/bin/sh

# Builds a selection of images used in the article.

images=(
  'consul-arm'
#  'docker-arm' # we have already done this
  'redis-arm'
  'swarm-arm'
  'node4.x-arm'
  'expresslite4.x'
  'expressredis4.x'
  'nginx_dynamic'
)

function build {
	echo "Entering $1"
	echo "Building $1/Dockerfile"
	cd $1
	./build.sh
	cd ..
	echo
}

for project in "${images[@]}"
do
    build $project
done

