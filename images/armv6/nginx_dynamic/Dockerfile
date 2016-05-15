FROM alexellis2/node4.x-arm:v6

RUN apt-get -y update && \
    apt-get install -qy nginx

ADD ./init.sh ./init.sh
#ADD node_modules ./node_modules
ADD package.json ./package.json
RUN npm install

ADD app.js ./app.js

WORKDIR /etc/nginx
RUN rm nginx.conf
ADD nginx.conf nginx.conf
EXPOSE 80
WORKDIR /root/
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chmod +x init.sh

CMD ["./init.sh"]
