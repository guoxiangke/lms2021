FROM composer:latest AS vendor
WORKDIR /var/www/html/
COPY ./laravel/composer* ./
RUN composer install \
  --no-dev \
  --no-interaction \
  --prefer-dist \
  --optimize-autoloader \
  --ansi \
  --no-scripts

#
# Frontend
#
FROM node:latest as frontend

RUN mkdir -p /app/public
# package-lock.json
COPY ./laravel/webpack.mix.js ./laravel/package.* /app/
COPY ./laravel/resources /app/resources

WORKDIR /app

RUN npm install && npm run production


#
# Application
#
FROM drupal:9.2-php8.0-apache
# https://hub.docker.com/_/drupal

# install the PHP extensions  pcntl
RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    libonig-dev\
  ; \
  docker-php-ext-install -j "$(nproc)" \
    mbstring \
    pcntl \
    bcmath \
  ; \
  \
  rm -rf /var/lib/apt/lists/*
  
RUN rm -rf /var/www/html \
  && mkdir /var/www/html

COPY ./laravel /var/www/html
COPY --from=vendor /var/www/html/vendor /var/www/html/vendor
COPY --from=frontend /app/public/ /var/www/html/public/

COPY docker/start.sh /usr/local/bin/start
WORKDIR /var/www/html

RUN chown -R www-data:www-data storage bootstrap/cache \
  && chmod -R ug+rwx storage bootstrap/cache \
  && chmod u+x /usr/local/bin/start

ENV APACHE_DOCUMENT_ROOT /var/www/html/public/
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

CMD ["/usr/local/bin/start"]

