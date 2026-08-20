#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

: "${pSelf:?pSelf is not defined}"
# locate recorder.sh to locate the record-*.sh files
pRecorder="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Shell-state recorders must be sourced so they can see
# aliases, functions, shell variables, and shell options.
source "${pRecorder}/record-alias.sh"
source "${pRecorder}/record-env.sh"
source "${pRecorder}/record-functions.sh"
source "${pRecorder}/record-shell-options.sh"

# System-state recorders can run as independent processes.
"${pRecorder}/record-system.sh"
"${pRecorder}/record-topology.sh"
"${pRecorder}/record-network.sh"
"${pRecorder}/record-toolchain.sh"


