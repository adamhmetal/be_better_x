#!/usr/bin/env bash

COMMIT_ID=$(git log --format="%h" -n 1)
IMAGE_TAG="$REGISTRY_URL:$COMMIT_ID"

function build_image() {
    echo "Image: $IMAGE_TAG"
    docker build -f infrastructure/docker/Dockerfile -t "$IMAGE_TAG" .
}

function push_image() {
    docker build -f infrastructure/docker/Dockerfile -t "$IMAGE_TAG" .
}

# $1: 0=run forever with inotifywait, 1=run once and exit
function run_tests() {
    echo "Running unit tests"
    COMMIT_ID=$COMMIT_ID docker-compose -f infrastructure/docker/docker-compose.yml run -e LIVE_RELOAD=$1 --rm --service-ports --entrypoint /vol/app/tests/cli/run_tests.sh app
}
