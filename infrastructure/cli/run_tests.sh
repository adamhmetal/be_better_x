#!/usr/bin/env bash

print_usage_and_exit() {
    echo "Usage: $0 [-r]" 1>&2
    exit 1
}

live_reload=false

while getopts "rt:" opt; do
    case "${opt}" in
        r)
            live_reload=true
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

source infrastructure/cli/common.sh

build_image || exit 1

if [ "${live_reload}" = true ]; then
    run_tests true
else
    run_tests false
fi
