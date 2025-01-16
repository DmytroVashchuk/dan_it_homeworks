# Використовуємо офіційний Python-образ
FROM python:3.9-slim

# Копіюємо скрипт у контейнер
COPY python-random.py /app/python-random.py

# Переходимо в робочу директорію
WORKDIR /app

# Встановлюємо необхідні залежності (немає зовнішніх залежностей у цьому проєкті)
RUN chmod +x python-random.py

# Відкриваємо порт 8082
EXPOSE 8082

# Запускаємо додаток
CMD ["python3", "python-random.py"]
