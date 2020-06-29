FROM node:latest

ENV APP_ROOT /src
ENV HOST 0.0.0.0

WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}
RUN npm install && npm run build