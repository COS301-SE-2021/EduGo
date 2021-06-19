#!/usr/bin/env bash

set -e

docker-compose up -d db

WAIT_FOR_PG_ISREADY="while ! pg_isready --quiet; do sleep 1; done;"
docker-compose exec db bash -c "$WAIT_FOR_PG_ISREADY"

# Create database for this environment if it doesn't already exist.
docker-compose exec db \
    su - postgres -c "psql test -c '' || createdb test"

docker-compose up -d