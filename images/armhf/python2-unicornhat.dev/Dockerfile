FROM alexellis2/python2-armhf:2
RUN apt-get -qy update && apt-get -qy --no-install-recommends install git python-dev python-pip build-essential
WORKDIR /root/
# clone git to get all sources and exemples
RUN git clone https://github.com/pimoroni/unicorn-hat
# but install via pip
RUN  pip install unicornhat &&  \
  rm -rf /var/lib/apt/lists/* && \
  apt-get -qy clean all

WORKDIR /root/unicorn-hat/examples/

CMD ["/bin/bash"]
