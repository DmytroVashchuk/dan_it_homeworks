#!/bin/bash

# Встановлення MySQL
sudo apt-get update
sudo apt-get install -y mysql-server

# Налаштування MySQL для доступу з інших хостів
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Створення користувача і бази даних
DB_USER='db_user'
DB_PASS='db_pass'
DB_NAME='petclinic'

mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
mysql -u root -e "CREATE DATABASE ${DB_NAME};"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

