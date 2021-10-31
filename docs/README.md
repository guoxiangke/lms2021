# README.md

## GOAL

- ALL IN Docker
- Refactor of LMS with laravel v8 and php 8.


## Installing laravel/laravel (v8.6.5) 
 docker run --rm \
    -u ${UID}:${UID} \
    -v $(pwd):/app \
    -w /app \
    composer \
    php -d memory_limit=-1 \
    /usr/bin/composer \
    create-project --prefer-dist laravel/laravel \
    laravel

## Develop

- cp .env laravel/
- sudo chown 33:33 laravel/storage/ -R

## Install PEST
docker-compose exec app composer require pestphp/pest-plugin-laravel --dev

## TDD test

	docker-compose exec app php artisan test
	docker-compose exec app vendor/bin/phpunit --filter xxx