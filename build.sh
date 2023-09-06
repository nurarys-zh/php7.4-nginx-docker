#!/bin/bash
docker build ./ -t php_fpm:7.4-`date '+%Y%m%d_%H%M%S'` --file Dockerfile
