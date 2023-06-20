#! /bin/sh

docker compose build --no-cache
docker compose run frontend yarn install
docker compose up -d
