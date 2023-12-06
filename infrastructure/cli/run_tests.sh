#!/usr/bin/env bash

print_usage_and_exit() {
    echo "Usage: $0 [-r] [-t <unit|integration>]" 1>&2
    exit 1
}

live_reload=false

while getopts "rt:" opt; do
    case "${opt}" in
        r)
            live_reload=true
            ;;
        t)
            type=${OPTARG}
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
        *)
            print_usage_and_exit
            ;;
    esac
done
shift $((OPTIND-1))

if [ "${live_reload}" = true ] && [ -z "${type}" ]; then
    print_usage_and_exit
fi

source infrastructure/cli/common.sh

build_image || exit 1

if [ "${live_reload}" = true ]; then
    if [ "${type}" = "unit" ]; then
        run_unit_tests true
    elif [ "${type}" = "integration" ]; then
        run_integration_tests true
    else
        echo "Invalid test type: ${type}" >&2
        print_usage_and_exit
    fi
else
    run_unit_tests false && run_integration_tests false
fi
