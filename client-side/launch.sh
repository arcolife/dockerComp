#!/bin/bash

## Steps to build a docker image
# docker pull fedora:20
# cd client-side/docker
# docker build -t arcolife/docker_comp .
# docker run -d arcolife/docker_comp

docker pull arcolife/docker_comp

# docker  run -it  -p :80 arcolife/docker_comp bash
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp
docker run -d arcolife/docker_comp

echo "4 containers are ready to be deployed for analysis"

docker ps > containers_details
