FROM armhf/alpine:latest
workdir /root
RUN apk add --update libarchive-tools
ADD https://github.com/prometheus/prometheus/releases/download/v1.4.1/prometheus-1.4.1.linux-armv7.tar.gz /root/
RUN bsdtar -xvf prometheus-1.4.1.linux-armv7.tar.gz -C ./ --strip-components=1

RUN mkdir -p /usr/share/prometheus
RUN mkdir -p /etc/prometheus

RUN cp prometheus                             /bin/prometheus
RUN cp promtool                               /bin/promtool
RUN cp prometheus.yml  /etc/prometheus/prometheus.yml
RUN cp -r console_libraries/                     /usr/share/prometheus/console_libraries/
RUN cp -r consoles/                              /usr/share/prometheus/consoles/

#RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/usr/share/prometheus/console_libraries", \
             "-web.console.templates=/usr/share/prometheus/consoles" ]

