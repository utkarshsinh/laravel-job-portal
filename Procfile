web: echo "Checking build directory..." && ls -la public/ | grep build || echo "Build directory not found" && mkdir -p public/build && php artisan config:clear && php artisan cache:clear && php artisan migrate --force && (php artisan db:seed --force || echo "Seeding skipped") && php artisan config:cache && php artisan route:cache && php artisan view:cache && php -S 0.0.0.0:$PORT -t public

