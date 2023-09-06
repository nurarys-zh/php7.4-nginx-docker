#!/bin/bash
docker network create -d bridge --subnet=172.20.0.0/16 dockernet -o "com.docker.network.bridge.name"="dockernet"
docker run -d --name php7.4 --log-driver=journald --restart=unlessstopped --ip=172.20.0.5 --network="dockernet" php_fpm:7.4
