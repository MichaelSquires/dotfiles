#!/bin/sh

export DOCKER_UID=`id -u`
export DOCKER_GID=`id -g`
export DOCKER_USERNAME=`whoami`

docker build \
    --rm \
    -t ubuntu-dev:latest \
    --build-arg UID=${DOCKER_UID} \
    --build-arg GID=${DOCKER_GID} \
    --build-arg USERNAME=${DOCKER_USERNAME} \
    .
