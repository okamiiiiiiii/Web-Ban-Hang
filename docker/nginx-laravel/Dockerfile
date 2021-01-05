FROM nginx:1.17.6-alpine

ENV TZ JST-9

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
