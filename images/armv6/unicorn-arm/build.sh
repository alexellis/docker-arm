#!/bin/bash

if [ ! -d unicorn-hat ];
then
   git clone https://github.com/pimoroni/unicorn-hat
fi

docker build -t unicorn-hat .

