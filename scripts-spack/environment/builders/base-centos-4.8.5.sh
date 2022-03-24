#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# start timer
export master=${SECONDS}
export  myPython="^python@3.10.2"
export myOpenMPI="^openmpi@4.1.2"

# source ${repo_scripts_spack}/environment/builders/base-centos-4.8.5.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

build_target="gcc@11.2.0"

new_step "Build ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info gcc"
              spack info gcc > ${SPACK_ROOT}/${USER}/info/gcc.txt &

    sub_step "spack install ${build_target}"
              $(date) > ${SPACK_ROOT}/${USER}/build-logs/${fileName}
              echo "spack install ${build_target} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}"
                    spack install ${build_target} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}

    sub_step "spack compiler find $(spack location -i ${build_target})"
              spack compiler find $(spack location -i ${build_target})

build_target="gdb"
new_step "Build debugger ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

    sub_step "spack install ${build_target} ${myPython}"
              $(date) > ${SPACK_ROOT}/${USER}/build-logs/${fileName}
              echo "spack install ${build_target} ${myPython} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}"
                    spack install ${build_target} ${myPython} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}

build_target="valgrind"
new_step "Build ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

    sub_step "spack install ${build_target} ${myOpenMPI}"
              $(date) > ${SPACK_ROOT}/${USER}/build-logs/${fileName}
              echo "spack install ${build_target} ${myOpenMPI} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}"
                    spack install ${build_target} ${myOpenMPI} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}


build_target="tau"
new_step "Build ${tau}+fortran"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}+fortran"
              spack spec ${build_target}+fortran > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

    sub_step "spack install ${build_target}+fortran ${myPython} ${myOpenMPI}"
              $(date) > ${SPACK_ROOT}/${USER}/build-logs/${fileName}
              echo "spack install ${build_target}+fortran ${myPython} ${myOpenMPI} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}"
                    spack install ${build_target}+fortran ${myPython} ${myOpenMPI} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/${fileName}

export master=$((${SECONDS}-${master}))
printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
