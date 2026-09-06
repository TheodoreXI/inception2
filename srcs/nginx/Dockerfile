FROM debian:12

#the paths of the keys must change

RUN apt-get update && apt-get install -y nginx openssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /nginx-selfsigned.key -out /etc/ssl//certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=Maroc/L=AGADIR/O=42/CN=aakroud.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "deamon off;"]

