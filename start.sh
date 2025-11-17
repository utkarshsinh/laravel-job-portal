#!/bin/bash
set -e

echo "Clearing caches..."
php artisan config:clear || true
php artisan cache:clear || true

echo "Running migrations..."
php artisan migrate --force

echo "Seeding database..."
php artisan db:seed --force || echo "Seeding skipped or already done"

echo "Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting server on port $PORT..."
php -S 0.0.0.0:$PORT -t public

