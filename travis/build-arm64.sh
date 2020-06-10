#!/bin/bash
set -ev

# Set Build Options
PLATFORM=arm64
DOCKERFILE_LOCATION="./docker/Dockerfile.arm64"
DOCKER_IMAGE="ytd2"
DOCKER_TAG="latest"

# If This Isn't A PR, Push to Dockerhub
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin

    buildctl build --frontend dockerfile.v0 \
        --progress=plain \
        --opt platform=linux/${PLATFORM} \
        --opt filename=${DOCKERFILE_LOCATION} \
        --opt build-arg:TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST} \
        --output type=image,name=docker.io/${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM},push=true \
        --local dockerfile=. \
        --local context=.
else
    # If This is a PR, Build to Check for Errors
    buildctl build --frontend dockerfile.v0 \
        --progress=plain \
        --opt platform=linux/${PLATFORM} \
        --opt filename=${DOCKERFILE_LOCATION} \
        --opt build-arg:TRAVIS_PULL_REQUEST=false \
        --output type=docker,name=${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM} \
        --local dockerfile=. \
        --local context=. \
        | docker load
fi
