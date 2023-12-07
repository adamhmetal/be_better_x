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


