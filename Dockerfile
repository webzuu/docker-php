FROM php:7-fpm

RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*

RUN pecl install mongodb-1.1.8 \
    && docker-php-ext-enable mongodb

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install exif

RUN apt-get install -y \
        libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl