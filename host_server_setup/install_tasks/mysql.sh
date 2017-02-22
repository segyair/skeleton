#!/bin/bash

# https://support.rackspace.com/how-to/installing-mysql-server-on-centos/
echo "-- Installing mysql"
sudo yum install mysql-server -y
sudo /sbin/service mysqld start
# do the following steps instead of runnin $mysql_secure_installation
# http://stackoverflow.com/questions/24270733/
# Make sure that NOBODY can access the server without a password
mysql -uroot -e "UPDATE mysql.user SET Password = PASSWORD('1') WHERE User = 'root'"
# Kill the anonymous users
mysql -uroot -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -uroot -e "DROP USER ''@'$(hostname)'"
# Disallow remote login for root 
mysql -uroot -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
# Kill off the demo database
mysql -uroot -e "DROP DATABASE test"
# Make our changes take effect
mysql -uroot -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

sudo yum install mysql-devel -y

sudo chkconfig --level 345 mysqld on