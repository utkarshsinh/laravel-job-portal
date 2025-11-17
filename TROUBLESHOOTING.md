# Troubleshooting Railway Deployment

## Internal Server Error - Quick Fixes

### 1. Check Railway Logs
In Railway Dashboard → Your Service → Deployments → Click on active deployment → "View logs"

Look for:
- PHP errors
- Database connection errors
- Missing file/directory errors
- Permission errors

### 2. Common Issues & Solutions

#### Issue: APP_KEY missing or invalid
**Solution:** Make sure `APP_KEY` is set in Railway Variables

#### Issue: Database connection failed
**Solution:** Verify all DB_* variables are set correctly with Postgres references

#### Issue: Storage permissions
**Solution:** Railway should handle this, but if needed, add to start command:
```bash
chmod -R 775 storage bootstrap/cache || true
```

#### Issue: Cached config causing errors
**Solution:** The start command now clears cache before starting

#### Issue: Seeder failing
**Solution:** The seeder now uses `|| echo` so it won't block server startup

### 3. Enable Debug Mode Temporarily

To see detailed errors, temporarily set in Railway Variables:
```
APP_DEBUG=true
```

**⚠️ Remember to set back to `false` after fixing!**

### 4. Manual Database Seeding

If seeding fails during deployment, you can seed manually:

**Option A: Via Railway CLI**
```bash
railway run --service laravel-job-portal php artisan db:seed --force
```

**Option B: Add to start command temporarily**
The current config includes seeding. After first successful seed, you can remove it.

### 5. Verify Environment Variables

Make sure all these are set:
- ✅ APP_ENV=production
- ✅ APP_DEBUG=false (or true for debugging)
- ✅ APP_KEY=base64:...
- ✅ APP_URL=https://...
- ✅ DB_CONNECTION=pgsql
- ✅ DB_HOST=${{Postgres.PGHOST}}
- ✅ DB_PORT=${{Postgres.PGPORT}}
- ✅ DB_DATABASE=${{Postgres.PGDATABASE}}
- ✅ DB_USERNAME=${{Postgres.PGUSER}}
- ✅ DB_PASSWORD=${{Postgres.PGPASSWORD}}
- ✅ FILESYSTEM_DISK=public
- ✅ SESSION_DRIVER=file

### 6. Check Build Output

Verify in Railway logs that:
- ✅ Composer install succeeded
- ✅ npm run build succeeded
- ✅ Migrations ran successfully
- ✅ Server started on correct port

### 7. Test Database Connection

Run in Railway console:
```bash
php artisan tinker
```
Then:
```php
DB::connection()->getPdo();
```

If this works, database connection is fine.

