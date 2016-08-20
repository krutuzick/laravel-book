FROM php:7-fpm
MAINTAINER krutuzick <krutuzick@gmail.com>

# Unpack sources
RUN docker-php-source extract

# Set timezone
RUN echo Europe/Moscow | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Upgrade & install server software
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    bzip2 \
    curl \
    g++ \
    git \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    mc \
    openssl \
    sendmail \
    && rm -r /var/lib/apt/lists/*

# Install phpredis extension
ENV PHPREDIS_VERSION php7

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis\
    && echo "redis" >> /usr/src/php-available-exts

# Install PHP Extensions
RUN docker-php-ext-install opcache mbstring pdo pdo_mysql pdo_pgsql zip bcmath iconv redis tokenizer
RUN docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd

# install composer
RUN \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer;

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nodejs && rm -r /var/lib/apt/lists/*

# install gulp
RUN npm install --g gulp-cli

# workaround for bug https://github.com/boot2docker/boot2docker/issues/581
RUN usermod -u 1000 www-data

# Cleanup sources
RUN docker-php-source delete

# Cleanup apt
RUN \
    apt-get autoremove -y && \
    apt-get clean all

COPY env/docker/app/php.ini /usr/local/etc/php/php.ini

VOLUME /var/www

WORKDIR /var/www