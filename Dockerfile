FROM php:alpine

#### php composer ####

ENV PHP_COMPOSER_VERSION 1.2.0

RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer --version=$PHP_COMPOSER_VERSION

#### xdebug ####

RUN set -ex \
    && apk add --no-cache --virtual .xdebug-builddeps \
        autoconf \
        gcc \
        libc-dev \
        make \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .xdebug-builddeps

#### mysql ####

RUN docker-php-ext-install pdo_mysql
