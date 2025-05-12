FROM python:3.10

# Встановлюємо залежності: Java, wget, unzip, бібліотеки для графічного інтерфейсу, supervisor
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    openjdk-17-jdk \
    libxext6 libxrender1 libxtst6 libxi6 \
    supervisor \
    && rm -rf /var/lib/apt/lists/*


ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64


# Завантажити та встановити IB Gateway
RUN wget https://download2.interactivebrokers.com/installers/ibgateway/stable-standalone/ibgateway-stable-standalone-linux-x64.sh -O /tmp/ibgateway-installer.sh && \
    chmod +x /tmp/ibgateway-installer.sh && \
    /tmp/ibgateway-installer.sh -q && \
    rm /tmp/ibgateway-installer.sh

# Завантажити IBC (IB Controller)
RUN wget https://github.com/IbcAlpha/IBC/releases/download/3.22.0/IBCLinux-3.22.0.zip -O /tmp/IBC.zip && \
    unzip /tmp/IBC.zip -d /opt/ibc && \
    chmod +x /opt/ibc/scripts/*.sh && \
    rm /tmp/IBC.zip


# Копіюємо код проєкту
WORKDIR /app
COPY requirements.txt /app/requirements.txt

# Встановлюємо Python залежності
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо конфігурацію для IBC, supervisord і стартовий скрипт
COPY config.ini /opt/ibc/config.ini
COPY supervisord.conf /etc/supervisord.conf
COPY ibcstart.sh /opt/ibcstart.sh
RUN chmod +x /opt/ibcstart.sh



# Запуск супервізора для контролю процесів
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
