FROM	debian:buster

#update apt and install mariadb server
RUN	apt-get update
RUN	apt-get install -y mariadb-server

#expose port 
EXPOSE	3306

#copy config file and init script
COPY	./conf/mariadb.cnf /etc/mysql/mariadb.conf.d
COPY	./tools/init.sql /var/www/

#start mariadb and run init script
RUN	service mysql start && mysql < /var/www/init.sql && rm -f /var/www/init.sql;

#start mariadb
CMD ["mysqld"]

