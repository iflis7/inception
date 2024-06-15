#!/bin/bash

# Check if /run/php directory exists; if not, start and immediately stop php7.4-fpm service to create the directory
if [ ! -d /run/php ]; then
  service php7.4-fpm start
  service php7.4-fpm stop
fi

# Check if WP_ADMIN_LOGIN contains "admin"; if true, display error and exit with status 1
if [[ ${WP_ADMIN_LOGIN,,} == *"admin"* ]]; then
  echo "Error: Username must not contain 'admin'"
  exit 1
fi

# Check if WP_ADMIN_PASSWORD contains WP_ADMIN_LOGIN (case insensitive); if true, display error and exit with status 1
if [[ ${WP_ADMIN_PASSWORD,,} == *${WP_ADMIN_LOGIN,,}* ]]; then
  echo "Error: Password must not contain the username"
  exit 1
fi

# If wp-config.php does not exist, setup WordPress using wp-cli commands
if [ ! -f /var/www/html/wp-config.php ]; then
  # Download WordPress core
  wp core download --allow-root --path=/var/www/html
  
  # Create wp-config.php with database credentials
  wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306
  
  # Install WordPress with provided configuration
  wp core install --allow-root --url="${DOMAIN}" --title="${WP_TITLE}" --admin_name="${WP_ADMIN_LOGIN}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email
  
  # Create additional user (if provided)
  wp user create --allow-root "${WP_USER_LOGIN}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author
  
  # Start php-fpm7.4 in foreground mode
  /usr/sbin/php-fpm7.4 -F
fi

# If wp-config.php exists, start php-fpm7.4 in foreground mode
if [ -f /var/www/html/wp-config.php ]; then
  /usr/sbin/php-fpm7.4 -F
fi
