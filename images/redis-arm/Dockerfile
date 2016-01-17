FROM armhf/ubuntu
RUN apt-get -qq update && \
  apt-get -qy install redis-server
USER root
#RUN echo "vm.overcommit_memory = 1'" |tee -a /etc/sysctl.conf
EXPOSE 6379
CMD ["redis-server"]
