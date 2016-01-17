#!/bin/bash
set -e  
        
FILES="Dockerfile.armhf contrib/download-frozen-image-v2.sh Makefile hack/make/.detect-daemon-osarch"

echo Cloning Docker repository

git clone https://github.com/docker/docker.git docker-1.9
cd docker-1.9

echo Patching 1.9.1 source

for file in $FILES; do
  cp $file $file.save
done

git checkout v1.9.1 
for file in $FILES; do
  mv $file.save $file 
done            

# 1.9 doesn't want to be built with seccomp        
sed -i 's/ENV DOCKER_BUILDTAGS apparmor seccomp/ENV DOCKER_BUILDTAGS apparmor/' Dockerfile.armhf
sed -i 's/export DOCKERFILE/export DOCKERFILE=Dockerfile.armhf/' Dockerfile.armhf
                
echo
echo 'Everything is set up. Now try "cd docker-1.9" and "make binary"'
