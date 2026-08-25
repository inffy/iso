#!/usr/bin/env bash
# Shared retry helper for CI steps. Source this file, then call:
#   retry <number of tries> <seconds between retries> <command> [args...]
set -euo pipefail

retry() {
    if [[ "${#}" -lt 3 ]]; then
        echo "retry usage: <number of tries> <time between retries> <command> ..."
        return 1
    fi
    tries="${1}"
    sleep="${2}"
    shift 2
    for i in $(seq 1 "${tries}"); do
        if [[ ${i} -gt 1 ]]; then
            sleep "${sleep}"
        fi
        "${@}" && r=0 && break || r=$?
    done
    return "$r"
}
