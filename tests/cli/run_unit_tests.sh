#!/usr/bin/env bash
red='\033[0;31m' # Color red
green='\033[0;32m' # Color green
no_color='\033[0m' # Color reset (no color)

source tests/cli/common.sh

function run_tests {
    local exit_result

    echo -e "= TEST RUN: $(date) ="

    pytest

    if [[ "$?" -ne 0 ]]; then
        exit_result=1
        echo -e "\n${red}Unit tests result: fail${no_color}"
    else
        exit_result=0
        echo -e "\n${green}Unit tests result: success${no_color}"
    fi

    print_debug_info

    if [ "${LIVE_RELOAD}" == "false" ]; then
        exit ${exit_result}
    else
        echo -e "\nPress Ctrl+C to stop testing.\n"
    fi
}

run_tests
while inotifywait -qq -r -e moved_to -e create -e modify -e delete -e close_write /vol --exclude=".*___"; do
    run_tests
done
