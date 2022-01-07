FROM php:8.0-fpm-alpine as build

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN git clone https://github.com/knobik/cloud-init-mailer.git /app && \
    cd /app && \
    composer setup && \
    composer install

FROM php:8.0-fpm-alpine

# using nginx cuz php-cli for some reason does not want to read env values.
RUN apk update && apk upgrade && \
    apk add --no-cache nginx

COPY .docker/nginx.conf /etc/nginx/http.d/default.conf
COPY .docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY --from=build --chown=www-data:www-data /app /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
