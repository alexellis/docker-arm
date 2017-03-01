FROM armhf/alpine:3.5
workdir /root
RUN apk add --update libarchive-tools
ADD https://github.com/prometheus/alertmanager/releases/download/v0.5.1/alertmanager-0.5.1.linux-armv6.tar.gz /root/
RUN bsdtar -xvf *.tar.gz -C ./ --strip-components=1
RUN mkdir /etc/alertmanager

RUN cp alertmanager               /bin/alertmanager
RUN cp simple.yml    /etc/alertmanager/config.yml

EXPOSE     9093
VOLUME     [ "/alertmanager" ]
WORKDIR    /alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "-config.file=/etc/alertmanager/config.yml", \
             "-storage.path=/alertmanager" ]

