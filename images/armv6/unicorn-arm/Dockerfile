FROM alexellis2/python-gpio-arm:armv6

WORKDIR /root/
ADD ./unicorn-hat/ ./unicorn-hat/

RUN apt-get -q update && \
	apt-get -qy install python-dev python-pip gcc make && \
	pip install rpi-ws281x && \
	pip install UnicornHat && \
  apt-get -qy remove python-dev gcc make && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get -qy clean all

CMD ["python2", "./unicorn-hat/python/examples/phat_rainbow.py"]
