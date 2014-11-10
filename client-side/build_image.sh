#!/bin/bash

## Steps to build a docker image

docker pull ubuntu:trusty
# cd docker
docker build -t arcolife/docker_comp .
#docker run -d arcolife/docker_comp
