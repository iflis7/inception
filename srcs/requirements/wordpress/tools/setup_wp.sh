#! /bin/bash

# Replace the listen directive in the php-fpm configuration file with port 9000
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";

# Change ownership of all files in /var/www to www-data user and group
chown -R www-data:www-data /var/www/*;

# Set permissions to 755 for all files in /var/www
chown -R 755 /var/www/*;

# Create directory for php-fpm pid file
mkdir -p /run/php/;

# Create php-fpm pid file
touch /run/php/php7.3-fpm.pid;

# If wp-config.php does not exist in /var/www/html, install WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: Set Up ..."
	mkdir -p /var/www/html
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;

	# Make wp-cli.phar executable
	chmod +x wp-cli.phar; 

	# Move wp-cli.phar to /usr/local/bin/wp
	mv wp-cli.phar /usr/local/bin/wp;

	# Change to /var/www/html directory
	cd /var/www/html;

	# Download the latest WordPress version
	wp core download --allow-root;

	# Move wp-config.php to /var/www/html/

	echo "Wordpress: Creating Users ..."


if ! wp core is-installed --allow-root; then
    if [ ! -f /var/www/html/wp-config.php ]; then
        wp config create --dbname="${MYSQL_NAME}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --allow-root
    fi
    wp core install --allow-root --url="${WP_URL}" --title="WordPress" --admin_user="${WP_ADMIN_LOGIN}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}"
    wp user create --allow-root "${WP_USER_LOGIN}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}"
    echo "WordPress: Setup Done!"
else
    echo "WordPress is already installed."
fi



	# Install WordPress with wp-cli
#	wp core install --allow-root --url=${WP_URL} --title="wordpress" --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} 
		
	echo "Here: " ${MYSQL_NAME} ${MYSQL_HOST}	

#	wp config create --dbname="${MYSQL_NAME}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --allow-root
	# Create a new user with wp-cli
#	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	
#	cp ./conf/wp-config.php /var/www/html/
	echo "Wordpress: Set Up Done!"
fi

# Run the command passed as arguments to this script
exec "$@"
