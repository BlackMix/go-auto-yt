#!/bin/bash
set -ev
export DOCKER_CLI_EXPERIMENTAL=enabled

docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
docker manifest create ${DOCKER_USER}/ytd2:latest
docker manifest annotate ${DOCKER_USER}/ytd2:latest --arch arm64
docker manifest push ${DOCKER_USER}/ytd2:latest
