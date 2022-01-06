FROM php:8-fpm-alpine as build

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN git clone https://github.com/knobik/cloud-init-mailer.git /app && \
    cd /app && \
    composer setup && \
    composer install

FROM php:8-fpm-alpine

COPY --from=build /app /app

RUN addgroup -S mailer && adduser -S mailer -G mailer
RUN chown -R mailer:mailer /app
USER mailer

EXPOSE 8000

ENTRYPOINT ["php", "/app/artisan", "serve", "--host", "0.0.0.0"]
