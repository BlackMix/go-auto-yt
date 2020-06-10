#!/bin/bash
set -ev
export DOCKER_CLI_EXPERIMENTAL=enabled

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
    docker login -u $DOCKER_USER -p $DOCKER_PASSWORD

    docker manifest create ${DOCKER_USER}/go-auto-yt:latest \
            ${DOCKER_USER}/go-auto-yt:latest-arm64

    docker manifest annotate ${DOCKER_USER}/go-auto-yt:latest ${DOCKER_USER}/go-auto-yt:latest-arm64 --arch arm64

    docker manifest push ${DOCKER_USER}/go-auto-yt:latest
else
    docker images
fi
