FROM node:14-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY tsconfig*.json ./
COPY src src
RUN npm run build

FROM node:14-alpine AS tester
WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig*.json ./
RUN npm i
COPY tests tests
COPY src src
RUN npm run test

FROM node:14-alpine
RUN apk add --no-cache tini
WORKDIR /usr/src/app
RUN chown node:node .
USER node
COPY package*.json ./
RUN npm install
COPY --from=builder /usr/src/app/lib/ lib/
EXPOSE 3000
ENTRYPOINT [ "/sbin/tini","--", "node", "lib/server.js" ]
