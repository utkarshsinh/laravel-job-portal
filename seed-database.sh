#!/bin/bash
# One-time database seeding script for Railway
# Run this in Railway console: bash seed-database.sh

php artisan db:seed --force

