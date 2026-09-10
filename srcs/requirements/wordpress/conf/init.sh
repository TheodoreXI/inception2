#!/bin/bash

WP_PATH="/var/www/wordpress"

# Move to the WordPress directory
cd "$WP_PATH"

# Check if WordPress is already configured and installed
if ! wp core is-installed --allow-root >/dev/null 2>&1; then

    # Read secrets securely from the file paths provided by Docker secrets
    DB_PASS="$(cat /run/secrets/db_password)"
    ADMIN_PASS="$(cat /run/secrets/credentials)"
    USER_PASS="$(cat /run/secrets/credentials_2)"

    # 1. Create wp-config.php file securely using environment variables and secrets
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root

    # 2. Complete the primary administrator installation
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    # 3. Create the mandatory second non-administrator user
    wp user create \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$USER_PASS" \
        --allow-root
fi

# Set correct ownership for the web server user
chown -R www-data:www-data "$WP_PATH"

# MANDATORY: Launch PHP-FPM in the foreground (-F). 
# Using 'exec' ensures PHP-FPM becomes PID 1, completely avoiding hacky infinite loops.
exec php-fpm8.2 -F
