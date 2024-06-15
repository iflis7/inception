FROM debian:oldstable

#Maintainer
LABEL description="Inception"
LABEL version="1.0"

# Update and upgrade existing packages
RUN apt update -y && apt upgrade -y

# Install PHP-FPM, Wget, PHP-MySQL, MariaDB Client
RUN apt install -y php-fpm wget php-mysql mariadb-client

# Copy custom PHP-FPM pool configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# Download WP-CLI (WordPress Command Line Interface), make executable, and move to global bin directory
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy the WordPress setup script and make it executable
COPY tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set working directory for WordPress installation
WORKDIR /var/www/html

# Set entry point to run the WordPress setup script
ENTRYPOINT [ "/wordpress.sh" ]
