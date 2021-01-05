FROM php:8.0-fpm-alpine

# Set work directory
WORKDIR /var/www/html

#### timezone ####
ENV TZ JST-9;

#### base ####
ADD ./docker/laravel/composer.phar /usr/local/bin/
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN apk update
RUN set -ex

#### php.ini ####
RUN { \
    echo 'date.timezone = Asia/Tokyo'; \
    echo 'expose_php = Off'; \
} > /usr/local/etc/php/conf.d/00-base.ini

#### xdebug ####
RUN apk add --no-cache --virtual xdebug-builddeps \
    autoconf \
    gcc \
    libc-dev \
    make \
    && pecl install xdebug \
    && apk del --purge xdebug-builddeps

#### pdo_pgsql & opcache####
RUN apk --no-cache add \
    postgresql-dev
RUN docker-php-ext-install pdo \
    pdo_pgsql \
    opcache

#### redis ####
RUN apk add --no-cache --virtual .redis \
    build-base \
    autoconf
RUN pecl install -o -f redis \
    && docker-php-ext-enable redis
RUN apk del --purge .redis
RUN rm -rf /tmp/pear

#### copy app ####
COPY ./src /var/www/html

#### composer ####
ADD ./docker/laravel/composer-cache.tar.gz /var/www/

#### entry point ####
COPY ./docker/laravel/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
