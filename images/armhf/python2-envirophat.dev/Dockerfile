FROM alexellis2/python2-gpio-armhf:2-dev
RUN apt-get -qy update && apt-get -qy --no-install-recommends install git python-smbus
WORKDIR /root/
RUN git clone https://github.com/pimoroni/enviro-phat
WORKDIR /root/enviro-phat/library
RUN python2 ./setup.py install

#CMD ["/bin/bash"]
entrypoint ["/bin/bash"]

