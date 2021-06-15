#!/usr/bin/env bash
DOCKER_IMAGE="$1"
ARG="$2"
docker run --rm -v $(pwd)/generated_certs:/tmp $DOCKER_IMAGE $ARG