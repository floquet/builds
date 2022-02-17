#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Dec  3 12:31:35 MST 2021

# start the timer
export SECONDS=0
# timestamp results
export ymdt=$(date +%Y-%m-%d_%H,%M)

# counts steps in batch process
export counter=0
export sub_counter=0
export sub_sub_counter=0

function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step(){
    sub_counter=$((sub_counter+1))
    echo ""
    echo "  ${counter}.${sub_counter}: ${1}"
}

function sub_sub_step(){
    sub_sub_counter=$((sub_sub_counter+1))
    echo ""
    echo "  ${counter}.${sub_counter}.${sub_sub_counter}: ${1}"
}

function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

# file header
function file_header(){
    echo "created by ${HOME}/${BASH_SOURCE[0]} at $(date)" >> ${1}
    echo ""                               >> ${1}
    echo "\${SPACK_ROOT} = ${SPACK_ROOT}" >> ${1}
    echo ""                               >> ${1}
    echo "spack arch $(spack arch)"       >> ${1}
    echo ""                               >> ${1}
    echo "uname -a:"                      >> ${1}
    uname -a                              >> ${1}
    echo ""                               >> ${1}
}
