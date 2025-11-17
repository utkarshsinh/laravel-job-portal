Deployment (Railway)

Overview
- Runtime: PHP 8.2/8.3, Laravel 11, Node 20 for Vite.
- DB: Use Railway PostgreSQL (recommended) or MySQL.
- Build: Composer install + Vite build.
- Start: Run migrations and serve `public/`.

Steps
1) Push this repo to GitHub (or let CI push it).
2) Create a Railway account and a new project.
3) Deploy from GitHub: connect your repo and select main branch.
4) Add a Database: PostgreSQL plugin in the same project.
5) Configure env vars for the Web Service:
   - APP_ENV=production
   - APP_DEBUG=false
   - APP_URL=https://<your-domain>
   - DB_CONNECTION=pgsql
   - DB_HOST=${{PGHOST}}
   - DB_PORT=${{PGPORT}}
   - DB_DATABASE=${{PGDATABASE}}
   - DB_USERNAME=${{PGUSER}}
   - DB_PASSWORD=${{PGPASSWORD}}
   - FILESYSTEM_DISK=public
   - SESSION_DRIVER=file
   - APP_KEY: Generate locally via `php artisan key:generate --show` and paste.

6) Build & start commands (Service settings → Deploy → Nixpacks):
   - Build Command:
     composer install --no-dev --prefer-dist --optimize-autoloader \
     && php artisan storage:link || true \
     && npm ci \
     && npm run build
   - Start Command:
     php artisan migrate --force \
     && php -S 0.0.0.0:8080 -t public

7) Expose port 8080 (Railway autodetects).
8) Redeploy. App should come up at the generated URL.

Notes
- The built-in PHP server is fine for demos/small apps. For production-hardening, front with Caddy/NGINX + PHP-FPM.
- If you prefer MySQL, add a MySQL plugin and set DB_* vars accordingly.
- Run `php artisan optimize` during build for extra performance if desired.

Alternative: Render
- Create a Web Service from the repo.
- Add a managed PostgreSQL instance.
- Environment:
  APP_ENV=production, APP_DEBUG=false, DB_CONNECTION=pgsql, APP_KEY=<generated>.
- Build Command: same as above.
- Start Command: same as above.

