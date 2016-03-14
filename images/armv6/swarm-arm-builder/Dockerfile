FROM alexellis2/go-arm:v6_1.5

WORKDIR $GOPATH/src/github.com/docker/
RUN git clone https://github.com/docker/swarm
WORKDIR $GOPATH/src/github.com/docker/swarm
RUN mkdir -p /usr/lib/go/pkg/linux_arm_netgo/
ENV CGO_ENABLED 0
ENV PATH \
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/go/bin

RUN godep go install -v -a -tags netgo -installsuffix netgo -ldflags '-extldflags "-static" -s' .
WORKDIR /root/
ADD ./export_binary.sh ./

CMD ["/go/bin/swarm", "--help"]
