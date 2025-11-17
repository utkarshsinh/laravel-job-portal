web: php artisan optimize:clear && php artisan view:clear && php artisan config:clear && php artisan route:clear && php artisan cache:clear && composer dump-autoload && php artisan migrate --force && (php artisan db:seed --force || echo "Seeding skipped") && php artisan config:cache && php artisan route:cache && php artisan view:cache && php -S 0.0.0.0:$PORT -t public

