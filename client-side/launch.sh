#!/bin/bash

docker pull arcolife/docker_comp

# docker  run -it  -p :80 arcolife/docker_comp bash
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp

echo "4 containers are ready to be deployed for analysis"

docker ps > containers_details
