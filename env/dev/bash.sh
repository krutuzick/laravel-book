#!/bin/bash
set -e
cd $(cd $(dirname $0) && pwd)

echo "Executing bash into app container..."

exec docker exec -it laravelbookdev_app_1 bash