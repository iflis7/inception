#!/bin/bash

# Change ownership of MySQL data directory to mysql user
chown -R mysql:mysql /var/lib/mysql

# Initialize MySQL data directory and suppress output
mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db >> /dev/null

# Temporary SQL file for MySQL commands
TEMPFILE='tmpfile.sql'

# Write SQL commands to the temporary SQL file
echo "FLUSH PRIVILEGES;" > $TEMPFILE
echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> $TEMPFILE
echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> $TEMPFILE
echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';" >> $TEMPFILE
echo "ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> $TEMPFILE
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> $TEMPFILE
echo "FLUSH PRIVILEGES;" >> $TEMPFILE

# Bootstrap MySQL server with the temporary SQL file
mysqld --user=mysql --bootstrap < $TEMPFILE

# Remove the temporary SQL file
rm -f $TEMPFILE

# Start MySQL server in safe mode
exec mysqld_safe

