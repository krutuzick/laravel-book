#!/bin/bash
set -e
cd $(cd $(dirname $0) && pwd)

echo "Removing all services...";
docker-compose down -v

echo "Building all services...";
docker-compose build

echo "Recreating all services...";
docker-compose up -d

echo "Waiting for database server to accept connections..."
timeout=30
while ! docker exec laravelbookdev_db_1 /usr/bin/pg_isready -d laravel -t 3 -q
do
    timeout=$(($timeout - 3))
    if [ ${timeout} -eq 0 ]; then
      echo -e "\nCould not connect to database server. Aborting..."
      exit 1
    fi
    echo -n "."
    sleep 3
done
echo

sleep 3

./run.sh bin/composer-install.sh

./run.sh bin/migrate.sh

./run.sh bin/build-frontend.sh
