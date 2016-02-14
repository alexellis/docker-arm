### node4.x-arm

The image provides Node 4.x and the necessary packages to build native *npm* modules/extensions. At the time of publishing this is 4.2.4, to update this to a newer version change the following lines:

```
RUN wget https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-armv7l.tar.gz
RUN tar -xvf node-v4.2.4-linux-armv7l.tar.gz -C /usr/local \
--strip-components=1
```
