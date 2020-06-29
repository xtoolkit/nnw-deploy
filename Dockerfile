FROM ubuntu:latest

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils

# Set the locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update
RUN apt-get install -y \
    git \
    curl \
    tar \
    php \
    php-cli \
    php-fpm \
    php-common \
    php-curl \
    php-json \
    php-xml \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-zip \
    php-memcached \
    php-gd \
    php-dev \
    php-soap \
    pkg-config \
    libcurl4-openssl-dev \
    libedit-dev \
    libssl-dev \
    libxml2-dev \
    npm \
    nginx \
    supervisor

# Cleanup
RUN apt-get clean

# wordpress
RUN mkdir -p /app \
    && curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -zxf wordpress.tar.gz -C /app/ \
    && rm -rf wordpress.tar.gz \
    && mv /app/wordpress/wp-config-sample.php /app/wordpress/wp-config.php

COPY wordpress/run.sh /usr/local/bin/
COPY wordpress/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
ADD wordpress/plugins /app/wordpress/wp-content/plugins
CMD ["wordpress/run.sh"]

# nginx
COPY default.conf /etc/nginx/conf.d/

# nuxt
ENV APP_ROOT /src
ENV HOST 0.0.0.0

WORKDIR ${APP_ROOT}
ADD nuxt ${APP_ROOT}
RUN npm install && npm run build && npm start
