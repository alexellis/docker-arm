FROM alexellis2/python2-armhf:2
ENTRYPOINT []
RUN apt-get -qy update && apt-get -qy --no-install-recommends install git python-dev python-pip build-essential
WORKDIR /root/
<<<<<<< HEAD
# Clone Git repo to fetch all sources and examples
=======
# Clone Git to get all sources and examples
>>>>>>> 4c3adcb1eea6678ef2ad8cb9d1072ab197407e2a
RUN git clone https://github.com/pimoroni/unicorn-hat
# But install via pip
RUN  pip install unicornhat &&  \
  rm -rf /var/lib/apt/lists/* && \
  apt-get -qy clean all
  
WORKDIR /root/unicorn-hat/examples/

CMD ["/bin/bash"]