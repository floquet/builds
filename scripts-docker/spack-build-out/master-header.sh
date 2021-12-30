#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export clicker=0
function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo " ${counter}.${clicker}: ${1}"
}

# spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
function spacktion(){
if ! command -v ${1} &> /dev/null
# 1. Build with package manager (yum, apt-get etc.), otherwise...
# 2. Build with Spack
then
    echo "No system definition for ${1}."
    echo "Using Spack to build ${1}."

    sub_step "spack install ${1} ${2}  >        ${3}"
    echo     "spack install ${1} ${2}" >        ${3}
              spack install ${1} ${2}  | tee -a ${3} 2>&1
              spack spec    ${1} ${2}  >        "${4}/${1}.txt" &
fi
}
