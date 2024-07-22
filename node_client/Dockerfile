# Вибір базового образу Node.js
FROM node:18

# Створення робочої директорії
WORKDIR /app

# Копіювання package.json та package-lock.json
COPY node_client/package.json ./
COPY node_client/package-lock.json ./

# Встановлення залежностей
RUN npm install

# Копіювання всіх файлів додатку
COPY node_client/ .

# Відкриття порту
EXPOSE 3001

# Запуск скрипту Node.js
CMD ["node", "main.js"]
