#!/bin/bash

docker pull arcolife/docker_comp

# docker  run -it  -p :80 arcolife/docker_comp bash
docker run -p :80 -d arcolife/docker_comp
docker run -p :80 -d arcolife/docker_comp
docker run -p :80 -d arcolife/docker_comp
docker run -p :80 -d arcolife/docker_comp

# echo "4 containers are ready to be deployed for analysis"

docker ps > containers_details
cd scripts/
python read_container_details.py
cd ..
curl -H "Content-type: application/json" -X POST http://104.131.170.133:5000/get_details/ -d @container_info.json
