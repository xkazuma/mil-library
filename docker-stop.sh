#! /bin/sh

docker compose kill && echo "yes" | docker compose rm && echo ""
