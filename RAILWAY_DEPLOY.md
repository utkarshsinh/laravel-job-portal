# Railway Deployment Steps (CLI Method)

## Current Status ✅
- ✅ Project linked: `railway link` completed
- ✅ Database created and integrated
- ✅ Code pushed to GitHub

## Next Steps

### 1. Set Environment Variables

You have two options:

#### Option A: Via Railway Web Dashboard (Recommended)
1. Go to https://railway.app and open your project
2. Click on your **Web Service** (not the database)
3. Go to the **Variables** tab
4. Add these variables:

**Required Variables:**
```
APP_ENV=production
APP_DEBUG=false
DB_CONNECTION=pgsql
FILESYSTEM_DISK=public
SESSION_DRIVER=file
```

**Database Variables (Use Railway References):**
- Click "Add Reference" for each:
  - `DB_HOST` → Reference `${{Postgres.PGHOST}}`
  - `DB_PORT` → Reference `${{Postgres.PGPORT}}`
  - `DB_DATABASE` → Reference `${{Postgres.PGDATABASE}}`
  - `DB_USERNAME` → Reference `${{Postgres.PGUSER}}`
  - `DB_PASSWORD` → Reference `${{Postgres.PGPASSWORD}}`

**APP_KEY:**
- After first deployment, Railway will generate this automatically, OR
- Generate locally: `php artisan key:generate --show` (requires `composer install` first)
- Add as: `APP_KEY=<generated-key>`

**APP_URL:**
- Will be set automatically by Railway after deployment
- Or set manually: `APP_URL=https://<your-railway-domain>`

#### Option B: Via Railway CLI
```bash
# Set variables one by one
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set DB_CONNECTION=pgsql
railway variables set FILESYSTEM_DISK=public
railway variables set SESSION_DRIVER=file

# For database, you'll need to reference the Postgres service
# This is easier via web UI
```

### 2. Deploy to Railway

Once environment variables are set, deploy:

```bash
railway up
```

This will:
- Build your application using `nixpacks.toml`
- Install dependencies
- Build frontend assets
- Run migrations
- Start the server

### 3. Get Your App URL

After deployment:
1. Railway will provide a public URL
2. Update `APP_URL` variable with this URL if needed
3. Your app should be live!

### 4. Generate APP_KEY (if not set)

If you didn't set APP_KEY before deployment, you can:

**Option 1: Via Railway Console**
1. Go to Railway dashboard → Your service → Deployments
2. Click on the latest deployment → Open Console
3. Run: `php artisan key:generate --show`
4. Copy the key and add it as `APP_KEY` variable
5. Redeploy

**Option 2: Generate Locally**
```bash
# Install dependencies first
composer install

# Generate key
php artisan key:generate --show

# Copy the output and add to Railway variables
```

### 5. Verify Deployment

- Check Railway logs for any errors
- Visit your Railway-provided URL
- Test the application

## Troubleshooting

- **Build fails**: Check Railway logs for specific errors
- **Database connection fails**: Verify database reference variables are set correctly
- **APP_KEY missing**: Generate and set it as shown above
- **Port issues**: Railway automatically handles `$PORT` variable

## Notes

- The `nixpacks.toml` file handles build/start commands automatically
- Railway will auto-detect PHP and Node.js versions
- Migrations run automatically on each deployment
- Storage link is created automatically during build

