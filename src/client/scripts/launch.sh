#!/bin/bash

docker pull arcolife/docker_comp

# docker  run -it  arcolife/docker_comp bash
docker run -it -d arcolife/docker_comp
docker run -it -d arcolife/docker_comp
docker run -it -d arcolife/docker_comp
docker run -it -d arcolife/docker_comp

# docker ps > containers_details
# cd scripts/
# python read_container_details.py
# cd ..
docker inspect $(docker ps -q | head -n 4) > container_info.json

curl -H "Content-type: application/json" -X POST http://$DC_HOST:$DC_PORT/get_details/ -d @container_info.json

echo "4 containers have been deployed.."
