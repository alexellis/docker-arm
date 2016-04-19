FROM alexellis2/python:armv6

# Use a single layer to minimize image size
RUN apt-get -q update && \
	apt-get -qy install python-dev python-pip gcc && \
  pip install rpi.gpio &&  \
  apt-get -qy remove python-dev gcc && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get -qy clean all
