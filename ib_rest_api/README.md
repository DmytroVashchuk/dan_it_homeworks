# IB Gateway + FastAPI

Цей проєкт контейнеризує **IB Gateway** і створює **REST API** за допомогою **FastAPI** для отримання інформації з облікового запису Interactive Brokers.

## Технології
- Docker
- FastAPI
- IB Gateway
- Python

## Налаштування

1. Склонуй репозиторій:
   ```bash
   git clone https://github.com/your_username/ib-rest-api.git
   cd ib-rest-api

Створення .env файлу у корені проекту

TWS_USER=your_username
TWS_PASSWORD=your_password
IBC_TRADING_MODE=paper
IBC_MODE=gateway
TWS_PORT=7497
IB_HOST=127.0.0.1
IB_CLIENT_ID=123

Цей файл не потрібно комітити у репозиторій, тому неохідно його додати у .gitignore


Створення каталогу для даних
Контейнер використовує зовнішній каталог ./data, який монтується всередину контейнера в /data. Усі тимчасові та лог-файли зберігаються тут.

Збірка та запуск контейнерів
docker-compose up --build
