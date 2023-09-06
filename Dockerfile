FROM alpine:latest

# Установка необходимых пакетов
RUN apk --no-cache add php7 php7-fpm nginx

# Копирование конфигурационных файлов
COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf

# Добавление индексного PHP-файла
COPY index.php /var/www/html/index.php

# Запуск сервисов
CMD ["sh", "-c", "php-fpm7 && nginx -g 'daemon off;'"]
