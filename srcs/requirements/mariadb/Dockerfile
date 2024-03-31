FROM debian:buster

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/init.sh /

RUN chmod +x ./init.sh

CMD ["/init.sh"]

