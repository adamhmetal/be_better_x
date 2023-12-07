#!/usr/bin/env bash

source infrastructure/cli/common.sh

build_image || exit 1

echo "Running coverage"
COMMIT_ID=$COMMIT_ID docker-compose -f infrastructure/docker/docker-compose.yml run -e LIVE_RELOAD=$1 --rm --service-ports --entrypoint /vol/app/tests/cli/coverage.sh app

