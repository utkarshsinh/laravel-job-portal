web: mkdir -p public/build && (npm run build || echo "Build skipped - using existing assets") && php artisan config:clear && php artisan cache:clear && php artisan migrate --force && (php artisan db:seed --force || echo "Seeding skipped") && php artisan config:cache && php artisan route:cache && php artisan view:cache && php -S 0.0.0.0:$PORT -t public

