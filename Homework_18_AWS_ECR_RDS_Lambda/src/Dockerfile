FROM node:16

# Встановлюємо робочу директорію
WORKDIR /app

# Копіюємо файли package.json та package-lock.json (якщо є) для встановлення залежностей
COPY package*.json ./

# Встановлення залежностей
RUN npm install

# Копіюємо решту файлів
COPY . .

# Виставляємо порт (за потреби)
EXPOSE 3000

# Запускаємо додаток
CMD ["npm", "start"]
