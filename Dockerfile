# base configuration
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# install required packages
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && \
    apt-get install -y \
    sqlite3 git \
    php8.0-cli \
    php8.0-sqlite3 \
    php8.0-redis\
    php8.0-gd \
    php8.0-ssh2 \
    php8.0-curl \
    php8.0-imap \
    php8.0-mbstring \
    php8.0-xml \
    php8.0-zip \
    php8.0-bcmath \
    php8.0-intl \
    php8.0-readline \
    php8.0-msgpack \
    php8.0-igbinary && \
    php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer && \
    mkdir /run/php && \
    apt-get -y autoremove && apt-get clean


RUN git clone https://github.com/knobik/cloud-init-mailer.git /app && \
    composer setup && \
    composer install -d /app

EXPOSE 8000

ENTRYPOINT ["php /app/artisan serve --host 0.0.0.0"]
