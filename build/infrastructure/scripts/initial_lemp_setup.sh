#!/bin/bash
set -euo pipefail

# this script is to install LEMP server on ubuntu server.

## Step 1 : Install nginx
apt-get update
apt-get -y install nginx
### remove unnecessary packages if any
apt-get -y autoremove
### allow nginx through ufw firewall
ufw allow 'nginx HTTP'

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

### apply the init_mysql.sql file to database as root user
mysql -u root mysql < init_mysql.sql

### deleting init file for security
rm init_mysql.sql


## Step 3 – Installing PHP and Configuring Nginx to Use the PHP Processor
### add Ubuntu’s universe repository, which includes free and open-source software maintained by the Ubuntu community
add-apt-repository universe
apt-get -y install php-fpm php-mysql

### create default example site to test nginx wih PHP
test_site='re7.helldorado.fr'
#### if EOF is not quoted, then '$, \ and `' caracters have to be escaped
#### see https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Here-Documents
cat << EOF >> /etc/nginx/sites-available/$test_site
server {
        listen 80;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name $test_site:;

        location / {
                try_files \$uri \$uri/ =404;
        }

        location ~ \\.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

        location ~ /\\.ht {
                deny all;
        }
}
EOF
### Enable your new server block by creating a symbolic link
ln -s /etc/nginx/sites-available/$test_site /etc/nginx/sites-enabled/
### Then, unlink the default configuration file from the /sites-enabled/ directory:
unlink /etc/nginx/sites-enabled/default
#### testing configuration file
### nginx -t
### reload nginx configuration
systemctl reload nginx

## Step 4 – Creating a PHP File to Test Configuration
cat << 'EOF' >> /var/www/html/info.php
<?php
phpinfo();
EOF
