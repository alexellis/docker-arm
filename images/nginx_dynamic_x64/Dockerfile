FROM node:4.2.4-wheezy

RUN apt-get -y update && \
    apt-get install -qy nginx

WORKDIR /root/

ADD ./init.sh ./init.sh
#ADD node_modules ./node_modules
ADD app.js ./app.js
ADD package.json ./package.json
RUN npm install

WORKDIR /etc/nginx
RUN rm nginx.conf
ADD nginx.conf nginx.conf
EXPOSE 80
WORKDIR /root/
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chmod +x init.sh

CMD ["./init.sh"]
