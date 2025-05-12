#!/bin/sh

# Замінюємо змінні в config.ini за допомогою envsubst
envsubst < /opt/ibc/config.ini > /opt/ibc/config_runtime.ini

# Просто виводимо повідомлення (замість запуску IBC.sh)
echo "[INFO] Створено config_runtime.ini:"
cat /opt/ibc/config_runtime.ini

# Тут міг би бути запуск IBC або інша логіка
tail -f /dev/null  # Залишити контейнер активним
