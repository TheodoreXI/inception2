FROM debian:12

RUN apt-get update && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl//certs/nginx-selfsigned.crt

COPY conf/default.conf /etc/nginx/conf.d/default.conf

