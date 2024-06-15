#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db >> /dev/null

OUTFILE='tmpfile.sql'

echo "FLUSH PRIVILEGES;" > $OUTFILE
echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> $OUTFILE
echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> $OUTFILE
echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';" >> $OUTFILE
echo "ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> $OUTFILE
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> $OUTFILE
echo "FLUSH PRIVILEGES;" >> $OUTFILE

mysqld --user=mysql --bootstrap < $OUTFILE

rm -f $OUTFILE

exec mysqld_safe

