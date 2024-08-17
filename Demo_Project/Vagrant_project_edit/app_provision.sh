
#!/bin/bash

# Оновлення списку пакетів та встановлення необхідних пакетів
# Встановлюємо OpenJDK 17 для запуску Java-додатків
# Встановлюємо Git для клонування репозиторіїв
# Встановлюємо Maven для зборки Java-проектів
sudo apt-get update
sudo apt-get install -y openjdk-17-jdk git maven nginx

# Налаштування nginx
# Конфігурація для того, щоб nginx працював з портом 82
sudo tee /etc/nginx/sites-available/default > /dev/null << EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Перезапускаємо службу nginx для застосування змін
sudo systemctl restart nginx

# Створюємо нового користувача app_user без пароля
# Цей користувач буде використовуватися для виконання додатків
sudo adduser --disabled-password --gecos "" app_user

# Виконуємо команди як користувач app_user
# Клонуємо репозиторій Spring PetClinic в домашню директорію app_user
# Збираємо проект за допомогою Maven
# Переміщуємо зібраний .jar файл до домашньої директорії app_user
sudo -i -u app_user bash << EOF
git clone https://github.com/spring-projects/spring-petclinic.git /home/app_user/project
cd /home/app_user/project
./mvnw package

# Переміщуємо зібраний .jar файл до домашньої директорії app_user
mv target/*.jar /home/app_user/app.jar
EOF

# Налаштовуємо середовищні змінні для підключення до бази даних
# Ці змінні будуть доступні для додатку при його запуску
echo "export DB_HOST=192.168.56.10" >> /home/app_user/.profile
echo "export DB_PORT=3306" >> /home/app_user/.profile
echo "export DB_NAME=petclinic" >> /home/app_user/.profile
echo "export DB_USER=db_user" >> /home/app_user/.profile
echo "export DB_PASS=db_pass" >> /home/app_user/.profile

# Створюємо файл сервісу для запуску додатку при завантаженні системи
# Налаштовуємо сервіс для запуску як app_user, з визначеними середовищними змінними
# Запускаємо додаток за допомогою java -jar
sudo tee /etc/systemd/system/petclinic.service > /dev/null << EOF
[Unit]
Description=PetClinic Spring Boot Application
After=network.target

[Service]
User=app_user
Environment=DB_HOST=192.168.56.10
Environment=DB_PORT=3306
Environment=DB_NAME=petclinic
Environment=DB_USER=db_user
Environment=DB_PASS=db_pass
ExecStart=/usr/bin/java -jar /home/app_user/app.jar
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

# Оновлюємо конфігурацію systemd для врахування нового сервісу
# Запускаємо сервіс та додаємо його до автозапуску при завантаженні системи
sudo systemctl daemon-reload
sudo systemctl start petclinic
sudo systemctl enable petclinic





