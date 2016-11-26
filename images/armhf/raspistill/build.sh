#!/bin/bash

cp -r /opt/vc ./opt_vc
docker build -t alexellis2/raspistill:latest .

