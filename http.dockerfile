FROM node:alpine

COPY . /app

WORKDIR /app

RUN npm i --production

CMD node .

EXPOSE 80
