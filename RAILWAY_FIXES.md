# Railway Deployment Fixes

## Issue 1: CSS Not Loading ✅ FIXED

**Problem:** CSS assets not loading in production.

**Solution Applied:**
- Updated `vite.config.js` to explicitly set build output directory
- Added caching commands to `nixpacks.toml` for better performance
- Pushed changes - Railway will auto-redeploy

**After Redeploy:**
1. Wait for Railway to finish building (check Deployments tab)
2. Verify CSS loads at: https://laravel-job-portal-production.up.railway.app
3. If still not working, check Railway logs for build errors

**If CSS still doesn't load:**
- Check that `APP_URL` is set correctly in Variables
- Verify `public/build` directory exists after deployment
- Check Railway build logs for Vite build errors

---

## Issue 2: Database Seeding

**Problem:** Can't access terminal in Railway to run seeder.

**Solution Options:**

### Option A: Add Temporary Seeder to Deployment (Easiest)

Temporarily modify `nixpacks.toml` start command to seed on first run:

```toml
[start]
cmd = "php artisan migrate --force && php artisan db:seed --force && php -S 0.0.0.0:$PORT -t public"
```

**Steps:**
1. Update `nixpacks.toml` with the command above
2. Push to GitHub: `git add nixpacks.toml && git commit -m "Add seeder to deployment" && git push`
3. Railway will redeploy and seed the database
4. **IMPORTANT:** After seeding succeeds, remove `&& php artisan db:seed --force` to avoid re-seeding on every deployment

### Option B: Use Railway CLI (If you can specify service)

```bash
railway run --service laravel-job-portal php artisan db:seed --force
```

### Option C: Railway Web Console

1. Go to Railway Dashboard
2. Click on your `laravel-job-portal` service
3. Go to the active deployment
4. Look for "Console" or "Shell" option (might be in Settings or Deployments)
5. Run: `php artisan db:seed --force`

---

## Quick Fix Commands

**To seed database (run in Railway environment):**
```bash
php artisan db:seed --force
```

**To check if assets are built:**
```bash
ls -la public/build
```

**To rebuild assets manually:**
```bash
npm run build
```

