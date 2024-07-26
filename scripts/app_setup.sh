#!/bin/bash

# Встановлення Java та інших залежностей
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk git

# Створення користувача для додатку
APP_USER='app_user'
sudo useradd -m -s /bin/bash ${APP_USER}
sudo -i -u ${APP_USER} bash << EOF
  cd ~
  git clone https://github.com/spring-projects/spring-petclinic.git project
  cd project
  ./mvnw package
EOF
# Налаштування змінних середовища та запуск додатку
sudo -i -u ${APP_USER} bash << EOF
  export DB_HOST=192.168.56.10
  export DB_PORT=3306
  export DB_NAME=petclinic
  export DB_USER=db_user
  export DB_PASS=db_pass
  java -jar ~/project/target/*.jar
EOF

