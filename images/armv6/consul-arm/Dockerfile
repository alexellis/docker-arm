FROM resin/rpi-raspbian

RUN apt-get update && apt-get -qy install \
 wget unzip ca-certificates
WORKDIR /root/
RUN wget \
 https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_arm.zip
RUN mkdir /data
RUN mkdir /ui
RUN unzip consul*.zip -d /usr/local/bin/

RUN consul version

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp

VOLUME ["/data"]
ADD ./config /config/

ENV DNS_RESOLVES consul
ENV DNS_PORT 8600

ENTRYPOINT ["/usr/local/bin/consul", "agent", "-config-dir=/config"]
