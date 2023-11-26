#!/bin/bash

# Check if the keys are generated before. If yes skip the process, if no create them.
if [ ! -f "./ssl/nginx.key" ] || [ ! -f "./ssl/nginx.crt" ]; then
    openssl req -x509 -nodes -newkey rsa:2048 -keyout ./ssl/nginx.key -out ./ssl/nginx.crt -days 365 -subj "/CN=localhost" -batch
fi

# build docker-image
sudo docker-compose build

# starts services
sudo docker-compose up
