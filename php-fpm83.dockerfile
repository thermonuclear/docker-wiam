FROM php:8.3-fpm

# ставим кучу пакетов, которые нужны для работы php
RUN apt-get update && apt-get install -y \
    build-essential \
    libzip-dev \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libonig-dev \
    locales \
    zip \
    unzip \
    curl \
    cron \
    mc \
    git \
    rename \
    ffmpeg \
#    libmagickwand-dev \
#    libwmf-bin \
#    imagemagick \
#    ghostscript \
#    python-uniconvertor \
#    inkscape \
#    default-jdk \
#    openjdk-21-jdk \
    libxtst6 \
    libxi6 \
    libxrender1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Clear cache
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#RUN curl -s https://download.axiomjdk.ru/axiomjdk-pro/21.0.4+9/axiomjdk-jdk-pro21.0.4+9-linux-amd64.deb -o axiomjdk-jdk-pro21.0.4+9-linux-amd64.deb && \
#    apt install -y ./axiomjdk-jdk-pro21.0.4+9-linux-amd64.deb;

#RUN git clone https://github.com/Imagick/imagick.git --depth 1 /tmp/imagick && \
#    cd /tmp/imagick && \
#    git fetch origin master && \
#    git switch master && \
#    cd /tmp/imagick && \
#    phpize && \
#    ./configure --with-wmf --with-svg && \
#    make && \
#   make install && \
#   docker-php-ext-enable imagick;

RUN set -eux; \
    # Install the PHP pdo_mysql extention
    docker-php-ext-install pdo_mysql; \
    docker-php-ext-install mysqli; \
#    docker-php-ext-install mcrypt; \
    # Install the PHP pdo_pgsql extention
    docker-php-ext-install pdo_pgsql; \
    docker-php-ext-install bcmath; \
    docker-php-ext-install zip; \
    docker-php-ext-install exif; \
    docker-php-ext-install pcntl; \
    # Install the PHP gd library
    docker-php-ext-configure gd \
            --prefix=/usr \
            --with-jpeg \
             --with-webp \
#            --with-freetype-dir \
            --with-freetype; \
    docker-php-ext-install gd; \
#    pecl install imagick && \
#    docker-php-ext-enable imagick; \
    # php -r 'var_dump(gd_info());'
    pecl install memcache-8.2 \
    && docker-php-ext-enable memcache; \
    pecl install redis-6.0.2 \
    && docker-php-ext-enable redis; \
    pecl install swoole-5.1.3 \
    && docker-php-ext-enable swoole; \
    # pecl install mcrypt-1.0.4 \
    # && docker-php-ext-enable mcrypt; \
    pecl install xdebug \
    && docker-php-ext-enable xdebug;

# php драйвер для работы с redis
# RUN pecl install redis-5.2.2 \
# 	# xdebug
#     && pecl install xdebug-2.9.6 \
#     && docker-php-ext-enable redis xdebug

#RUN pecl install pecl_http-3.2.2 \
#    && pecl install mcrypt- \
#    && docker-php-ext-enable pecl_http mcrypt
#    && docker-php-ext-enable pecl_http

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
#     apt-get install -y nodejs

# COPY ./php-fpm/project.ini /usr/local/etc/php/conf.d

# RUN mkdir -p /root/.ssh
# COPY ./ssh/id_rsa /root/.ssh/id_rsa
# RUN chmod 600 /root/.ssh/id_rsa
# RUN echo "StrictHostKeyChecking no\nIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config

WORKDIR /var/www/app
