Dev Docker Image for Unicorn HAT on Raspberry PI
================================================

This image does include a full Python 2.7 dev stack, with pip as well as Git and build-essentials.
It was not optimised for space.

Tested on a Raspberry Pi Zero, but should be compatible will the whole family.

The Pimoroni library for Unicorn HAT and pHAT is installed.

This image has to be run with the `--privileged` option like so:

    docker run -it --privileged alexellis2/python2-unicornhat-dev:2 

The library can auto-detect if you're using a Unicorn HAT or a Unicorn pHAT.

The default dir is the examples one, so you can test drive the demos, for instance:

	python rainbow.py
	
See the full [examples listing](https://github.com/pimoroni/unicorn-hat/tree/master/examples)

Note that some examples require extra Python libs that were not included (Numpy is one)
	
About the Unicorn HAT and pHAT
------------------------------
The Unicorn is a Raspberry Pi add on that provides a nice array of (very bright) RGB LEDs.
Those are individually addressable WS2812B LEDs.

It's made by [Pimoroni](https://shop.pimoroni.com) and comes in two flavors:

* The [Unicorn pHAT](http://shop.pimoroni.com/products/unicorn-phat) I used, 8x4 LEDs, will nicely fit your Raspberry Pi Zero
* The [Unicorn HAT](http://shop.pimoroni.com/products/unicorn-hat) is dedicated to the bigger Raspberry Pi 2 and 3, and comes with 8x8 LEDs
