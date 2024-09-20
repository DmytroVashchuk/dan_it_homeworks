# Базовий образ Python 3.9 на основі Slim (мінімальна версія)
FROM python:3.9-slim

# Встановлюємо робочу директорію всередині контейнера
WORKDIR /app

# Копіюємо файл requirements.txt у контейнер
COPY requirements.txt /app/requirements.txt

# Встановлюємо залежності з requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо всі інші файли в робочу директорію контейнера
COPY . /app

# Вказуємо порт, який буде використовуватись додатком
EXPOSE 8000

# Команда для запуску додатку за допомогою Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

