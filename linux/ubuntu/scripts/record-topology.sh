#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

: "${pSelf:?pSelf is not defined}"

# ----------------------------------------------------------------------
# Hardware topology
# ----------------------------------------------------------------------

topologyStart=$SECONDS

pTopology="${pSelf}/topology"
mkdir -p "${pTopology}"

pLog="${pTopology}/record-topology.log"
: > "${pLog}"

if ! command -v lstopo > /dev/null 2>&1; then
    printf "%s  lstopo: NOT FOUND\n" "$(date)" >> "${pLog}"
    exit 0
fi

# ----------------------------------------------------------------------
# Run one lstopo capture
#
# stdout/topology goes to the requested output file.
# stderr/messages go to a corresponding .messages.txt file.
# ----------------------------------------------------------------------

run_topology() {
    local name="$1"
    shift

    local start=$SECONDS
    local message_file="${pTopology}/${name}.messages.txt"

    : > "${message_file}"

    if timeout 10s lstopo \
        --force \
        --no-io \
        "$@" \
        2> "${message_file}"
    then
        printf "%s  %-20s OK       time=%d seconds\n" \
            "$(date)" "${name}" "$((SECONDS - start))" >> "${pLog}"
        return 0
    else
        local status=$?

        if [[ ${status} -eq 124 ]]; then
            printf "%s  %-20s TIMEOUT  time=%d seconds\n" \
                "$(date)" "${name}" "$((SECONDS - start))" >> "${pLog}"
        else
            printf "%s  %-20s FAILED   status=%d  time=%d seconds\n" \
                "$(date)" "${name}" "${status}" \
                "$((SECONDS - start))" >> "${pLog}"
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

# ----------------------------------------------------------------------
# Wait for all topology jobs
# ----------------------------------------------------------------------

wait "${pid1}" || true
wait "${pid2}" || true
wait "${pid3}" || true
wait "${pid4}" || true
wait "${pid5}" || true

printf "%s  %-20s COMPLETE  time=%d seconds\n" \
    "$(date)" "record-topology" "$((SECONDS - topologyStart))" >> "${pLog}"




