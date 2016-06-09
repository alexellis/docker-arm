FROM resin/rpi-raspbian

ADD ./vc /opt/vc/
RUN echo "/opt/vc/lib" > /etc/ld.so.conf.d/00-vmcs.conf
RUN ldconfig

CMD ["/opt/vc/bin/raspistill" "-o", "out.jpg"]

