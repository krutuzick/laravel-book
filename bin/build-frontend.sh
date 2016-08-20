#!/bin/bash
set -e

echo "Building frontend..."

cd /var/www
npm install
gulp

echo "Ok."