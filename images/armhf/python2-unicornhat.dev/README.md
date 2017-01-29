Dev Docker Image for unicorn hat on Raspberry PI
================================================

This image does include a full python 2.7 dev stack, with pip as well as git and build-essentials.
It was not optimised for space.

Tested on a Raspberry Pi Zero, but should be compatible will the whole family.

The Pimoroni library for Unicorn Hat and pHat is installed.

This image has to be run with the `--privileged` option like so:

    docker run -it --privileged alexellis2/python2-unicornhat-dev:2 

The library can auto-detect if you're using a Unicorn HAT or a Unicorn pHAT.

The default dir is the examples one, so you can test drive the demos, for instance:

	python rainbow.py
	
See the full [examples listing](https://github.com/pimoroni/unicorn-hat/tree/master/examples)

Note that some examples require extra python libs that were not included (numpy is one)
	
About the Unicorn Hat and pHat
------------------------------
The Unicorn is a Raspberry Pi add on that provides a nice array of (very bright) RGB leds.
Those are individually adressable WS2812B leds.

It's made by [Pimoroni](https://shop.pimoroni.com) and comes in two flavors:

* The [Unicorn pHat](http://shop.pimoroni.com/products/unicorn-phat) I used, 8x4 leds, will nicely fit your Raspberry Pi Zero
* The [Unicorn Hat](http://shop.pimoroni.com/products/unicorn-hat) is dedicated to the bigger Raspberry Pi 2 and 3, and comes with 8x8 leds

	
@actuino
http://www.actuino.fr/ (in french)