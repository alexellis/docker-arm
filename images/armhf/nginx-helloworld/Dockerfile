FROM armhf/alpine:latest
RUN apk add --update nginx && \
    mkdir -p /run/nginx/ && \
    rm /etc/nginx/conf.d/default.conf && \
    mkdir -p /var/www/html/ && \
    echo "<html>Welcome to your Raspberry Pi</html>" | tee -a /var/www/html/index.html

COPY raspberrypi.conf /etc/nginx/conf.d/

EXPOSE 80

RUN rm /var/www/html/index.html && ln -s /etc/hostname /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
