#!/bin/bash
set -e
cd /var/www

echo "Installing composer dependencies for app..."

export COMPOSER_PROCESS_TIMEOUT=3600
composer install -o -n

echo "Ok."