FROM resin/rpi-raspbian
WORKDIR /root/

RUN apt-get update && \
    apt-get -qy install curl unzip \
                build-essential python \
                ca-certificates \
                --no-install-recommends
RUN curl -sSLO \
    https://nodejs.org/dist/v6.9.2/node-v6.9.2-linux-armv6l.tar.gz && \
    tar -xf node-*.tar.gz -C /usr/local \
    --strip-components=1 && \
    rm node-*.tar.gz

CMD ["node"]
