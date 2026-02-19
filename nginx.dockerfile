# Базовый образ с nginx
FROM nginx:1.24

RUN apt-get update && apt-get install -y \
    openssl \
    mc \
    # Clear cache
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN apt-get clean && rm -rf /var/lib/apt/lists/*
# Удаляем конфиги сайтов которые там есть
#RUN rm -Rf /etc/nginx/conf.d/*
# Добавляем наш конфиг
#COPY nginx/site.conf /etc/nginx/conf.d

# создаем сертификат, если его нет.
# ADD ./nginx/scripts/startup.sh /etc/nginx/scripts/startup.sh
# RUN sed -i 's/\r//g' /etc/nginx/scripts/startup.sh
# CMD ["/bin/bash", "/etc/nginx/scripts/startup.sh"]
