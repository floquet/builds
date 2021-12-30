#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 18:20:31 MST 2021

# timestamp results
export ymdt=$(date +%Y-%m-%d-%H-%M) # timestamp results

# enumerate steps
function new_step(){
    step_counter=$((step_counter+1))
    echo ""
    echo "Step ${step_counter}: ${1}"
}

# enumerate substeps
function sub_step(){
    sub_step_counter=$((sub_step_counter+1))
    echo ""
    echo "  ${step_counter}.${sub_step_counter}: ${1}"
}