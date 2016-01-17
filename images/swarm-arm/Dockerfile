FROM scratch
ADD ./swarm /swarm

ADD ./certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENV SWARM_HOST :2375
EXPOSE 2375

VOLUME /.swarm

ENTRYPOINT ["/swarm"]
CMD ["--help"]


