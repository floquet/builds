#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# keep records on spack builds
export blogs="${SPACK_ROOT}/${USER}/build-logs"
export bspec="${SPACK_ROOT}/${USER}/specs"
export binfo="${SPACK_ROOT}/${USER}/info"

# should be created by generic-kickstart.sh
echo "mkdir -p ${blogs}"
      mkdir -p ${blogs}

echo "mkdir -p ${bspec}"
      mkdir -p ${bspec}

echo "mkdir -p ${binfo}"
      mkdir -p ${binfo}


# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "# $(date +%Y-%m-%d\ %H:%M): Step ${counter}: ${1}"
}

export clicker=0
function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo "# ${counter}.${clicker}: ${1}"
}

# spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
# https://stackoverflow.com/questions/1983048/passing-a-string-with-spaces-as-a-function-argument-in-bash
function spacktion(){
    # string arguments with spacing require eval
    eval    package=$1
    eval spack_args=$2
    eval   log_file=$3
    eval  spec_file=$4
# 1. Build with package manager (yum, apt-get etc.), otherwise...
# 2. Build with Spack
if ! command -v ${1} &> /dev/null
then
    # build with spack
    echo ""
    echo "No system definition for ${package} in ${dist}-${release}."
    echo "Using Spack to build ${package}."

    sub_step "spack install ${package} ${spack_args}  >  ${log_file}"
    echo     "$(date +%Y-%m-%d\ %H:%M)"               >  ${log_file}
    echo     "spack install ${package} ${spack_args}" >> ${log_file}
              spack install ${package} ${spack_args} 2>&1 | tee -a ${log_file}
              spack spec    ${package} ${spack_args}  2>&1 ${spec_file} &
              spack info    ${package}                2>&1 ${info_file} &
else
    # find existing build
    echo "Application ${package} already installed."
    echo "command -v ${package}"
          command -v ${package}
fi
}

function sweeper(){
# echo "${#list[@]} elements: ${list[@]}"
export  clicker=0
for p in ${list}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    export info_file="${binfo}/${p}.txt"
    echo "spack install ${p} ${cmd_line} > ${log_file}"
    echo "spack spec    ${p} ${cmd_line} > ${spec_file} &"
    echo "spack info    ${p}             > ${info_file} &"
done
}
