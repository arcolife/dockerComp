#!/bin/bash

docker pull fedora:20
cd client-side/docker
docker build -t arcolife/docker_comp .
docker run -d arcolife/docker_comp
