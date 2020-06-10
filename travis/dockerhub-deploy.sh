#!/bin/bash
set -ev
export DOCKER_CLI_EXPERIMENTAL=enabled

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin

    docker manifest create ${DOCKER_USER}/ytd2:latest \
            ${DOCKER_USER}/ytd2:latest-arm64

    docker manifest annotate ${DOCKER_USER}/ytd2:latest ${DOCKER_USER}/ytd2:latest-arm64 --arch arm64

    docker manifest push ${DOCKER_USER}/ytd2:latest
else
    docker images
fi
