#!/bin/bash
set -ev

# Set Build Options
PLATFORM=arm64
DOCKERFILE_LOCATION="./docker/Dockerfile.arm64"
DOCKER_IMAGE="ytd2"
DOCKER_TAG="latest"

docker login -u $DOCKER_USER -p $DOCKER_PASSWORD

buildctl build --frontend dockerfile.v0 \
    --progress=plain \
    --opt platform=linux/${PLATFORM} \
    --opt filename=${DOCKERFILE_LOCATION} \
    --opt build-arg:TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST} \
    --output type=image,name=docker.io/${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM},push=true \
    --local dockerfile=. \
    --local context=.
