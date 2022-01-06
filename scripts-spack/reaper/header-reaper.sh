#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Dec  3 12:31:35 MST 2021

# start the timer
export SECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d\ %H:%M)

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo "  ${counter}.${clicker}: ${1}"
}
# file header
function file_header{
    echo "created by ${HOME}/${BASH_SOURCE[0]} at $(date)" >> ${1}
    echo ""                               >> ${1}
    echo "\${SPACK_ROOT} = ${SPACK_ROOT}" >> ${1}
    echo ""                               >> ${1}
    echo "uname -a:"                      >> ${1}
    uname -a                              >> ${1}
    echo ""                               >> ${1}
}
