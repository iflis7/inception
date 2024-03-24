#! /bin/bash

# Replace the listen directive in the php-fpm configuration file with port 9000
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";

# Change ownership of all files in /var/www to www-data user and group
chown -R www-data:www-data /var/www/*;

# Set permissions to 755 for all files in /var/www
chmod -R 755 /var/www/*;

# Create directory for php-fpm pid file
mkdir -p /run/php/;

# Create php-fpm pid file
touch /run/php/php7.3-fpm.pid;

# If wp-config.php does not exist in /var/www/html, install WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress: Setting Up ..."

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

    # Create wp-config.php
    echo "<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to 'wp-config.php' and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '${MYSQL_NAME}');

/** MySQL database username */
define('DB_USER', '${MYSQL_USER}');

/** MySQL database password */
define('DB_PASSWORD', '${MYSQL_PASSWORD}');

/** MySQL hostname */
define('DB_HOST', '${MYSQL_HOST}');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
\$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define('ABSPATH', __DIR__ . '/');
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
" > /var/www/html/wp-config.php

    # Install WordPress with wp-cli
    wp core install --allow-root --url=${WP_URL} --title="WordPress" --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} 
    
    echo "WordPress: Setup Done!"
fi

# Run the command passed as arguments to this script
exec "$@"

