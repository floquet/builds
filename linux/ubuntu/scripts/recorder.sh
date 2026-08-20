#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

: "${pSelf:?pSelf is not defined}"

# locate recorder.sh to locate the record-*.sh files
pRecorder="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# record-system.sh      OS, kernel, CPU summary, RAM summary,
#                       disks, filesystems, mounts@
# record-proc.sh        raw kernel /proc information
# record-topology.sh    CPU/cache/NUMA hardware topology
# record-network.sh     interfaces, routes, DNS, sockets
# record-toolchain.sh   compilers and development tools

# Shell-state recorders must be sourced so they can see
# aliases, functions, shell variables, and shell options.
source "${pRecorder}/record-alias.sh"
source "${pRecorder}/record-env.sh"
source "${pRecorder}/record-functions.sh"
source "${pRecorder}/record-shell-options.sh"

# System-state recorders can run as independent processes.
"${pRecorder}/record-network.sh"
"${pRecorder}/record-proc.sh"
"${pRecorder}/record-system.sh"
"${pRecorder}/record-toolchain.sh"
"${pRecorder}/record-topology.sh"


