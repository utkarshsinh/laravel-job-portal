# Debug Steps for Internal Server Error

## Step 1: Enable Debug Mode (Temporarily)

In Railway Dashboard → Variables, temporarily change:
```
APP_DEBUG=true
```

This will show you the actual error instead of "Internal Server Error".

## Step 2: Check Railway Logs

1. Go to Railway Dashboard
2. Click on `laravel-job-portal` service
3. Click on the active deployment
4. Click "View logs"
5. Look for:
   - Red error messages
   - Stack traces
   - Database connection errors
   - File permission errors
   - Missing file errors

## Step 3: Common Errors & Quick Fixes

### Error: "No application encryption key has been specified"
**Fix:** Make sure `APP_KEY` is set in Variables

### Error: "SQLSTATE[08006] [7] could not connect to server"
**Fix:** Check all DB_* variables are set with Postgres references

### Error: "The stream or file could not be opened"
**Fix:** Storage permissions issue - Railway should handle this, but check logs

### Error: "Class 'X' not found"
**Fix:** Run `composer dump-autoload` - but this should be automatic

### Error: "Vite manifest not found"
**Fix:** Check that `npm run build` succeeded in build logs

## Step 4: Test Database Connection

After enabling debug, try accessing:
- https://laravel-job-portal-production.up.railway.app

You should see the actual error message instead of "Internal Server Error".

## Step 5: Share the Error

Once you see the actual error, share it and we can fix it specifically.

## Step 6: Disable Debug After Fixing

Once fixed, change back:
```
APP_DEBUG=false
```

