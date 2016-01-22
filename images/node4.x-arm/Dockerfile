FROM armhf/ubuntu
RUN apt-get update && \
    apt-get -qy install wget unzip \
                build-essential python

WORKDIR /root/
RUN wget \
  https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-armv7l.tar.gz
RUN tar -xvf node-v4.2.4-linux-armv7l.tar.gz -C /usr/local \
  --strip-components=1

CMD ["node"]
