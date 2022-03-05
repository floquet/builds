#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/builders/science-spack.sh

export master=${SECONDS}

# source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# source ${repo_scripts_docker}/bash-inits/paths.sh

export step_counter=0
export sub_step_counter=0
export sub_sub_step_counter=0

function pause(){
    echo ""
    echo "press RETURN to continue; ctrl+c to stop"
    read -p "$*"
}

# enumerate steps
function new_step(){
    step_counter=$((step_counter+1))
    echo ""
    echo "Step ${step_counter}: ${1}"
}

# enumerate subsubsteps
function sub_step(){
    sub_step_counter=$((sub_step_counter+1))
    echo ""
    echo "  ${step_counter}.${sub_step_counter}: ${1}"
}

# enumerate substeps
function sub_sub_step(){
    sub_sub_step_counter=$((sub_sub_step_counter+1))
    echo ""
    echo "  ${step_counter}.${sub_step_counter}.${sub_sub_step_counter}: ${1}"
}


# enumerate subsubsteps
# https://unix.stackexchange.com/questions/65932/how-to-get-the-first-word-of-a-string
function spack_sub_step(){
    sub_step_counter=$((sub_step_counter+1))
    export stringarray=(${1})
    echo "\${1} = ${1}"
    echo "\${2} = ${2}"
    echo "\${stringarray} = ${stringarray}"
    echo "\${1[0]} = ${1[0]}"
    echo "  ${step_counter}.${sub_step_counter}: ${1}"
}

new_step "parse commands packages"
  sub_step_counter=0

spack_sub_step "chapel ${myCompiler}"
