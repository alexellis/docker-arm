FROM alexellis2/python2-gpio-armhf:2-dev
RUN apt-get -qy update && apt-get -qy --no-install-recommends install git
WORKDIR /root/
RUN git clone https://github.com/pimoroni/explorer-hat
WORKDIR /root/explorer-hat/library/
RUN ls
RUN python2 ./setup.py install

CMD ["/bin/bash"]
