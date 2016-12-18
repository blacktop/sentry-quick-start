#!/bin/bash

set -e

echo "[SENTRY QUICK START]"

echo ">>> Building Sentry Image..."
docker build -t mysentry .

echo "  * Generate Sentry Secret Key"
export SENTRY_SECRET_KEY="$(docker run --rm mysentry config generate-secret-key)"

echo "  * Start redis"
docker run -d --name sentry-redis redis
echo "  * Start Postgres"
docker run -d --name sentry-postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=sentry postgres
sleep 10

echo "  * Configure DB"
docker run -it --rm -e SENTRY_SECRET_KEY --link sentry-postgres:postgres --link sentry-redis:redis mysentry upgrade

echo "  * Start Server"
docker run -d --name my-sentry -e SENTRY_SECRET_KEY --link sentry-redis:redis --link sentry-postgres:postgres -p 80:9000 mysentry

echo "  * Start Celery Beat"
docker run -d --name sentry-cron -e SENTRY_SECRET_KEY --link sentry-postgres:postgres --link sentry-redis:redis mysentry run cron
echo "  * Start Worker"
docker run -d --name sentry-worker-1 -e SENTRY_SECRET_KEY --link sentry-postgres:postgres --link sentry-redis:redis mysentry run worker

sleep 3
open http://localhost
