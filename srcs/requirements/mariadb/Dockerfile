# Use the Debian oldstable base image
FROM debian:oldstable

#Maintainer
LABEL description="Inception"
LABEL version="1.0"

# Update package lists, upgrade installed packages, and install MariaDB server
RUN apt update && apt upgrade -y && apt-get install mariadb-server -y

# Copy the MariaDB initialization script to the container
COPY tools/mariadb.sh /mariadb.sh

# Copy the MariaDB server configuration file to the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Make the MariaDB initialization script executable
RUN chmod +x /mariadb.sh

# Set the permissions for the MariaDB configuration file to read/write for the owner only
RUN chmod u=rw,go= /etc/mysql/mariadb.conf.d/50-server.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Set the initialization script as the entry point for the container
ENTRYPOINT [ "/mariadb.sh" ]
