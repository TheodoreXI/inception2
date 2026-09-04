#!/bin/bash
set -eu

DB_PASSWORD=$(tr -d '\r\n' < /run/secrets/db_password)
WP_PASSWORD=$(tr -d '\r\n' < /run/secrets/credentials)
WP_PATH="/srv/www/wordpress"

#Wait for mariadb to be ready

until mariadb -h mariadb -u"$MYSQL_USER" -p"$DB_PASS" -e "SELECT 1" >/dev/null 2>&1; do 
    sleep 2
done

#Setup wordpress if it hasnt been configured yet
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wp core download --allow-root

    wp config create --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost=mariadb
    
    wp core install --allow-root \
        --url="https://${DOAMIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin-user="${WP_ADMIN_USER}" \
        --admin_password="${WP_PASSWORD}" \
        --admin_emails="${WP_ADMIN_EMAIL}"
    
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_PASSWORD}" \
        --allow-root
fi

chown -R www-data:www /var/www/wordpress
exec php-fpm8.2 -F


