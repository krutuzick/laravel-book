#!/bin/bash
set -e
cd /var/www

echo "Migrate database..."

php artisan migrate --force -n -vvv

echo "Ok."