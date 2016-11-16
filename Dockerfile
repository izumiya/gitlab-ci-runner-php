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

#### extensions ####

RUN docker-php-ext-install pdo_mysql

#### PHP ImageMagick ####
RUN set -ex \
    && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS imagemagick-dev libtool \
    && pecl install imagick-3.4.1 \
    && docker-php-ext-enable imagick \
    && apk add --no-cache --virtual .imagick-runtime-deps imagemagick \
    && apk del .phpize-deps

#### zip ####

RUN set -ex \
    && apk add --no-cache --virtual .zip-builddeps \
        zlib-dev \
    && docker-php-ext-install zip \
    && apk del .zip-builddeps

#### perl ####

RUN set -ex \
    && apk add --no-cache perl

#### rsync ####

RUN set -ex \
    && apk add --no-cache rsync
