#!/usr/bin/env bash
cd /vol/app/ || exit

DEBUG_LOG="/tmp/debug.log"

function print_debug_info {
    if [[ -f "${DEBUG_LOG}" ]]; then
        cat "${DEBUG_LOG}"
        rm "${DEBUG_LOG}"
    fi
}

