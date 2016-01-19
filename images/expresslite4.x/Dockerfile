FROM alexellis2/node4.x-arm

ADD app.js ./
ADD package.json ./
RUN npm install

EXPOSE 3000

CMD ["node", "app.js"]
