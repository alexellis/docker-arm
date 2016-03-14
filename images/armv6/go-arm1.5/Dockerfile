FROM resin/rpi-raspbian

USER root

RUN apt-get update && apt-get -qy install git nano curl wget build-essential ca-certificates

RUN wget --no-check-certificate \
        http://dave.cheney.net/paste/go1.5.3.linux-arm.tar.gz
RUN tar -xf go*.tar.gz -C /usr/local/

ENV PATH \
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
RUN mkdir /go
ENV GOPATH /go
ENV AUTO_GOPATH 1
RUN go version
RUN AUTO_GOPATH=1 go get github.com/tools/godep

CMD ["go version"]
