#!/bin/bash
set -e
cd $(cd $(dirname $0) && pwd)

cmd=$@

exec docker exec -i -u www-data laravelbookdev_app_1 bash -c "${cmd}"