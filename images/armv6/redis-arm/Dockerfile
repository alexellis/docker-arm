FROM resin/rpi-raspbian

RUN apt-get -q update && \
  apt-get -qy install redis-server ca-certificates
USER root
#RUN echo "vm.overcommit_memory = 1'" |tee -a /etc/sysctl.conf
EXPOSE 6379
CMD ["redis-server"]
