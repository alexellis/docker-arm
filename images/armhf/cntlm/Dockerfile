FROM arm32v6/alpine:3.5

RUN apk add --no-cache \
            g++ \
            make \
            curl \
            bash \
            autoconf
RUN mkdir -p /usr/local/src/
WORKDIR /usr/local/src/
RUN curl -L -O http://downloads.sourceforge.net/sourceforge/cntlm/cntlm-0.92.3.tar.gz \
 && tar zxvf cntlm-0.92.3.tar.gz \
 && cd cntlm-0.92.3 \
 && ./configure \
 && make \
 && make install \
 && rm /usr/local/src/cntlm-0.92.3.tar.gz
RUN apk del curl \
            g++ \
            autoconf \
            make \
 && rm -rf /var/lib/apt/lists/*

FROM arm32v6/alpine:3.5
RUN apk add --no-cache make

COPY --from=0 /usr/local/src/ /usr/local/src/
WORKDIR /usr/local/src/cntlm-0.92.3

RUN make install
RUN sed -ie s/Listen/#Listen/g /etc/cntlm.conf
RUN echo "Listen 0.0.0.0:3128" | tee -a /etc/cntlm.conf 
CMD ["cntlm", "-f", "-g"]
