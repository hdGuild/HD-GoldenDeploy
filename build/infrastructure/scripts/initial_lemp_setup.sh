#!/bin/bash
set -euo pipefail

# this script is to install LEMP server on ubuntu server.

## Step 1 : Install Nginx
apt-get update
apt-get -y install Nginx
### remove unnecessary packages if any
apt-get -y autoremove
### allow nginx through ufw firewall
ufw allow 'Nginx HTTP'

### shows the nginx ip addresses
# ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

###  check which IP address is accessible, as viewStep 2 – Installing MySQL to Manage Site Dataed from other locations on the internet:
# curl -4 icanhazip.com

## Step 2 – Installing MySQL to Manage Site Data
apt-get -y install mysql-server
### remove unnecessary packages if any
apt-get -y autoremove
### generate mySQL password 
my_pwd=`openssl rand -base64 14`
# set default mysql security with no user interactivity
# mysql_secure_installation -D -p=$my_pwd
### the following script does the above code line.
cat << EOF >> init_mysql.sql
UPDATE mysql.user SET authentication_string=PASSWORD('$my_pwd') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF
### set the password for root user
mysql -u root mysql < init_mysql.sql
# deleting init file for security
rm init_mysql.sql







