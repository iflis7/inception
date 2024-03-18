FROM alpine:3.19.1

# Update apk and install mariadb server
RUN apk update && apk add --no-cache mariadb mariadb-client

# Expose port 
EXPOSE 3306

# Copy config file and init script
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init.sql /init_db.d

# Initialize the database
RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Use a custom script to start mariadb, run your script, and then safely stop mariadb
COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mysqld"]

