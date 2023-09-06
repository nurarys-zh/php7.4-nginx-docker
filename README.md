1. Create a local directory for the project and change into it:

mkdir php7.4-nginx-docker
cd php7.4-nginx-docker

2. Inside this directory, create a Dockerfile with the necessary instructions to build the container:

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


3. Create an nginx.conf file with Nginx settings:

worker_processes 1;
events { worker_connections 1024; }
http {
  server {
    listen 80;
    server_name localhost;
    location / {
      root /var/www/html;
      index index.php;
    }
    location ~ \.php$ {
      fastcgi_pass 127.0.0.1:9000;
      fastcgi_index index.php;
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
      include fastcgi_params;
    }
  }
}

4. Создайте файл php-fpm.conf с настройками PHP-FPM:

error_log = /var/log/php-fpm.log

5. Создайте файл index.php с содержанием:

<?php phpinfo(); ?>

6. Теперь создайте два скрипта для сборки и запуска контейнера. Создайте файл build.sh:

#!/bin/bash
docker build ./ -t php_fpm:7.4-`date '+%Y%m%d_%H%M%S'` --file Dockerfile

7. Создайте файл run.sh:

#!/bin/bash
docker network create -d bridge --subnet=172.20.0.0/16 dockernet -o "com.docker.network.bridge.name"="dockernet"
docker run -d --name php7.4 --log-driver=journald --restart=unlessstopped --ip=172.20.0.5 --network="dockernet" php_fpm:7.4

8. Сделайте скрипты исполняемыми:

chmod +x build.sh run.sh

9. Инициализируйте Git в директории проекта и свяжите его с вашим репозиторием GitHub:

git init
git remote add origin <URL-репозитория-GitHub>

10. Добавьте все файлы в Git и сделайте коммит:
git add .
git commit -m "Initial commit"

11. Загрузите проект на GitHub:

git push -u origin master

12. finish

будет доступна по адресу http://172.20.0.5 в вашей сети Docker.
