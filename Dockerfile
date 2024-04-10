FROM php:7.4-fpm

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./php /var/www/html
RUN composer install --no-dev --optimize-autoloader
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["php-fpm"]
