#!/bin/ash
chmod -R a+w /var/www/html/storage
chmod -R a+w /var/www/html/bootstrap/cache
chmod 755 /usr/local/bin/composer

if [ ! -e vendor ]; then
  composer install --no-dev
fi

if [ ! -e /var/www/html/.env ]; then
    cp /var/www/html/.env.example /var/www/html/.env
    php artisan key:generate
fi

php artisan migrate --seed --force

exec "$@"
