#!/bin/bash

cp -r /opt/vc ./
rm -rf ./vc/src
docker build -t alexellis2/raspistill .
