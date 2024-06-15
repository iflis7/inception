FROM    debian:oldstable

RUN     apt update && apt upgrade -y && apt-get install mariadb-server -y

COPY    tools/mariadb.sh /mariadb.sh
COPY    conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN     chmod +x /mariadb.sh
RUN     chmod u=rw,go= /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE  3306

ENTRYPOINT [ "/mariadb.sh" ]
