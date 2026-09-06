#!/bin/bash
set -eu

DB_PASSWORD=$(tr -d '\r\n' < /run/secrets/db_password)
DB_ROOT_PASSWORD=$(tr -d '\r\n' < /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
    mysqld_safe --skip-networking --datadir=/var/lib/mysql &

    until mysqladmin ping --silent 2>/dev/null; do
        sleep 1
    done 

    mysql -u root <<-EOF
        CREATE DATABSASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILIGES on \`${MYSQL_DATABASE}\è.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
        FLUSH PRIVILIGES;
EOF

    mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown;

fi

exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
