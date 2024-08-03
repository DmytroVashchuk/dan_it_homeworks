#!/bin/bash

# Оновлення списку пакетів та встановлення MySQL Server
# Це забезпечить, що у вас є остання версія MySQL Server
sudo apt-get update
sudo apt-get install mysql-server -y

# Налаштування MySQL для прийняття підключень з приватної мережі
# Замінюємо значення параметра bind-address на IP адресу приватної мережі
# Це дозволяє з'єднання з базою даних з іншої віртуальної машини
sudo sed -i "s/bind-address.*/bind-address = 192.168.56.10/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Перезапускаємо службу MySQL для застосування змін конфігурації
sudo systemctl restart mysql

# Створення нової бази даних з ім'ям 'petclinic'
# Це буде використовуватися додатком для зберігання даних
sudo mysql -u root -e "CREATE DATABASE petclinic;"

# Створення нового користувача 'db_user' з паролем 'db_pass'
# Користувач буде використовуватися для доступу до бази даних 'petclinic'
# '%' дозволяє підключення з будь-якого IP-адреси
sudo mysql -u root -e "CREATE USER 'db_user'@'%' IDENTIFIED BY 'db_pass';"

# Надання всіх привілеїв користувачу 'db_user' на базу даних 'petclinic'
# Це дозволяє користувачу виконувати всі операції з базою даних
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON petclinic.* TO 'db_user'@'%';"

# Оновлюємо привілеї для застосування змін
sudo mysql -u root -e "FLUSH PRIVILEGES;"

