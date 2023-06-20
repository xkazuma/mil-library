#!/bin/sh

# Preparing docker image
docker compose build

# Vite starts to create a project
docker compose run frontend yarn create vite

cp setup-2-mod-yml.sh setup-2-mod-yml.sh.bak
