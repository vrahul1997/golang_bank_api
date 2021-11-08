#! /bin/sh
# alpine image does nt have bash

# script will exit immediately after it returns null
set -e

# since the alpine image does nt have bash we have to start the migrate executable this way
echo "run db migration"
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@" app/main