#!/usr/bin/env bash
cd /vol/app/ || exit

red='\033[0;31m' # Color red
green='\033[0;32m' # Color green
yellow='\033[0;33m' # Color yellow
no_color='\033[0m' # Color reset (no color)

DEBUG_LOG="/tmp/debug.log"

function print_debug_info {
    if [[ -f "${DEBUG_LOG}" ]]; then
        cat "${DEBUG_LOG}"
        rm "${DEBUG_LOG}"
    fi
}

poetry install --with dev --no-root

if [ "${PYCHARM_DEBUG_VERSION_TAG}" != "" ]; then
  poetry run pip install pydevd-pycharm~=${PYCHARM_DEBUG_VERSION_TAG} > /dev/null
fi

function run_tests {
    local exit_result

    echo -e "= TEST RUN: $(date) ="

    local flags=""
    if [ "${LIVE_RELOAD}" == "true" ]; then
        local run_dev=false
        grep -r --include "*test*.py" "@pytest.mark.dev" /vol/app/tests | grep -v "#" > /dev/null && run_dev=true
        if [[ "${run_dev}" == "true" ]] ; then
            flags="-m dev"
            echo -e "\n${yellow}Running only selected tests with @pytest.mark.dev${no_color}"
        fi
    else
        flags="-p no:sugar"
    fi

    poetry run pytest ${flags}

    if [[ "$?" -ne 0 ]]; then
        exit_result=1
        echo -e "\n${red}Tests result: fail${no_color}"
    else
        exit_result=0
        echo -e "\n${green}Tests result: success${no_color}"
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
