FROM php:8-fpm-alpine as build

RUN apk update && apk upgrade && \
    apk add --no-cache git bash

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN git clone https://github.com/knobik/cloud-init-mailer.git /app && \
    cd /app && \
    composer setup && \
    composer install

RUN chmod +x /app/entrypoint.sh

FROM php:8-fpm-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash

COPY --from=build /app /app

#RUN addgroup -S mailer && adduser -S mailer -G mailer
#RUN chown -R mailer:mailer /app
#USER mailer

EXPOSE 8000

ENTRYPOINT ["/app/entrypoint.sh"]
