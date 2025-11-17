#!/bin/bash

echo "Clearing ALL caches (optimize:clear)..."
php artisan optimize:clear || true

echo "Clearing individual caches..."
php artisan view:clear || true
php artisan config:clear || true
php artisan route:clear || true
php artisan cache:clear || true

echo "Dumping autoload..."
composer dump-autoload || true

echo "Running migrations..."
php artisan migrate --force || exit 1

echo "Seeding database..."
php artisan db:seed --force || echo "⚠️  Seeding skipped or already done - this is OK"

echo "Caching configuration..."
php artisan config:cache || exit 1
php artisan route:cache || exit 1
php artisan view:cache || exit 1

echo "Starting server on port $PORT..."
exec php -S 0.0.0.0:$PORT -t public

