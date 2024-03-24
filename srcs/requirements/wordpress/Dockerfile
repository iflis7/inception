FROM	debian:buster

#Maintainer
LABEL	description="WordPress Inception"
LABEL	version="1.0"

#Install php-fmp
RUN	apt-get update
RUN	apt-get -y install php7.3 php-mysqli php-fpm wget sendmail curl 

#RUN	mkdir -p /var/www/html

#Expose wp port
EXPOSE	9000

#Copy the config file
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY	./tools /var/www/

#COPY	./conf/wp-config.php /var/www/html


#RUN	mkdir - /var/www/html
# Give permissions to run the script
RUN	chmod +x /var/www/setup_wp.sh

# Run the script
ENTRYPOINT	[ "/var/www/setup_wp.sh" ]

#Start the php-fpm server
CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]


