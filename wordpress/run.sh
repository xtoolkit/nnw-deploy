#!/bin/sh

# Wordpress config stuff
cd /app/wordpress
sed -i -e "s/database_name_here/wordpress/" wp-config.php
sed -i -e "s/username_here/wordpress/" wp-config.php
sed -i -e "s/password_here/wordpress/" wp-config.php
sed -i -e "s/localhost/db:3306/" wp-config.php
echo -e "define('FS_METHOD', 'direct');" >> wp-config.php

php -S 0.0.0.0:8080
