FROM debian:12

# Install PHP-FPM, MariaDB tools, and Curl dependencies
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl 

# FIX: Use the complete, official WP-CLI download path
RUN curl -o /usr/local/bin/wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Create runtime directories for WordPress and the PHP process socket
RUN mkdir -p /var/www/wordpress /run/php


# Download the core WordPress source code cleanly into the target folder
RUN wp core download --path=/var/www/wordpress --allow-root

# Modify the PHP config file to listen on port 9000 instead of a local Unix socket
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Copy our entrypoint script from our repository requirements directory
COPY conf/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh


# Tell the container runtime to launch our configuration script on bootup
ENTRYPOINT [ "init.sh" ]
