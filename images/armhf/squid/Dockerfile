FROM arm32v6/alpine:3.5

MAINTAINER alexellis2+docker@gmail.com

RUN apk --update add squid

# This step enables access from private IP address ranges (i.e. 169.x.x.x).
RUN sed s/"http_access deny all"/"http_access allow all"/g /etc/squid/squid.conf

CMD ["squid", "-NYCd", "1"]
