#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

: "${pSelf:?pSelf is not defined}"

# ----------------------------------------------------------------------
# Hardware topology
# ----------------------------------------------------------------------

pTopology="${pSelf}/topology"
mkdir -p "${pTopology}"

pLog="${pTopology}/record-topology.log"
: > "${pLog}"

if ! command -v lstopo > /dev/null 2>&1; then
    printf "%s  lstopo: NOT FOUND\n" "$(date)" >> "${pLog}"
    exit 0
fi

run_topology() {
    local name="$1"
    shift

    local error_file="${pTopology}/${name}.err"

    if timeout 10s lstopo \
        --force \
        --no-io \
        "$@" \
        2> "${error_file}"
    then
        printf "%s  %-20s OK\n" "$(date)" "${name}" >> "${pLog}"
        [[ -s "${error_file}" ]] || rm -f "${error_file}"
        return 0
    else
        local status=$?

        if [[ ${status} -eq 124 ]]; then
            printf "%s  %-20s TIMEOUT\n" "$(date)" "${name}" >> "${pLog}"
        else
            printf "%s  %-20s FAILED status=%d\n" \
                "$(date)" "${name}" "${status}" >> "${pLog}"
        fi

        return "${status}"
    fi
}

# ----------------------------------------------------------------------
# Run independent topology captures in parallel
# ----------------------------------------------------------------------

run_topology \
    lstopo \
    --of console \
    "${pTopology}/lstopo.txt" &
pid1=$!

run_topology \
    lstopo-verbose \
    --verbose \
    --of console \
    "${pTopology}/lstopo-verbose.txt" &
pid2=$!

run_topology \
    lstopo-physical \
    --physical \
    --of console \
    "${pTopology}/lstopo-physical.txt" &
pid3=$!

run_topology \
    lstopo-xml \
    --of xml \
    "${pTopology}/lstopo.xml" &
pid4=$!

run_topology \
    lstopo-svg \
    --of svg \
    "${pTopology}/lstopo.svg" &
pid5=$!

# Wait for all five jobs without printing anything.
wait "${pid1}" || true
wait "${pid2}" || true
wait "${pid3}" || true
wait "${pid4}" || true
wait "${pid5}" || true


