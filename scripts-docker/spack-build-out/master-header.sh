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
    # echo ""
    # echo "#   #   #   inside spacktion"
    eval package=$1
    eval spack_args=$2
    eval log_file=$3
    eval spec_file=$4
    # echo "\${1} = ${package}"
    # echo "\${2} = ${spack_args}"
    # echo "\${3} = ${log_file}"
    # echo "\${4} = ${spec_file}"
if ! command -v ${1} &> /dev/null
# 1. Build with package manager (yum, apt-get etc.), otherwise...
# 2. Build with Spack
then
    echo "No system definition for ${package} in ${dist}-${release}."
    echo "Using Spack to build ${package}."

    sub_step "spack install ${package} ${spack_args}  > ${log_file}"
    echo     "spack install ${package} ${spack_args}" > ${log_file}
              #spack install ${1} ${2}  | tee -a ${3} 2>&1
              #spack spec    ${1} ${2}  >        "${4}/${1}.txt" &
else
    echo "Application ${package} already installed."
    echo "command -v ${package}"
          command -v ${package}
fi
}
