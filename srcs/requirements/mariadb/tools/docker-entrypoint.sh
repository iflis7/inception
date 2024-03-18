#!/bin/sh
set -e

# Initialize the data directory
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo 'Initializing database'
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

# Start the MariaDB server
echo 'Starting MariaDB server'
exec mysqld_safe

