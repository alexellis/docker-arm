#!/bin/bash

blink()
{
  echo "$1" > /sys/class/gpio/gpio4/value
  sleep 0.5
}

setup()
{
  echo "4" > /sys/class/gpio/export
  echo "out" > /sys/class/gpio/gpio4/direction
}

teardown()
{
  echo "4" > /sys/class/gpio/unexport
}

setup

blink 0

for i in {0..10}; do
  echo "Blink $i/10"

  blink 1
  blink 0
done

teardown
