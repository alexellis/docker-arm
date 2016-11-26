FROM resin/rpi-raspbian:jessie

RUN mkdir -p /opt/vc/bin
COPY opt_vc /opt/vc
RUN echo "/opt/vc/lib" > /etc/ld.so.conf.d/00-vmcs.conf
RUN ldconfig

RUN ls -l /opt/vc/

ENV PATH $PATH:/opt/vc/bin/

RUN mkdir /root/images/
WORKDIR /root/images/

ENTRYPOINT ["/opt/vc/bin/raspistill"]
