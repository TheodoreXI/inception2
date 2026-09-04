FROM debian:12

RUN apt-get update && apt-get install -y mariadb-server


COPY conf/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306
ENTRYPOINT ["init.sh"]