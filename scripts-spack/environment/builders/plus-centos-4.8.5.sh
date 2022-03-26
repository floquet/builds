#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/builders/plus-centos-4.8.5.sh

# start timer
export master=${SECONDS}
# export  myPython="^python@3.10.2"
# export myOpenMPI="^openmpi@4.1.2"

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

export dlogs="${SPACK_ROOT}/${USER}/build-logs"

echo "\${dlogs} = ${dlogs}"

pause

export build_target="llvm@13.0.1"

new_step "Build ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info llvm"
              spack info llvm > ${SPACK_ROOT}/${USER}/info/${fileName}.txt &

    sub_step "spack install ${build_target}"
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}
              echo "spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}

    sub_step "spack compiler find $(spack location -i ${build_target})"
              spack compiler find $(spack location -i ${build_target})

export build_target="py-tqdm"
new_step "Build python application ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

<<<<<<< Updated upstream
    sub_step "spack install ${build_target} ${myCompiler} ${myPython}"
=======
    sub_step "spack install ${build_target} ${myOpenMPI}"
>>>>>>> Stashed changes
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}
              echo "spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}

export build_target="py-urllib3"
new_step "Build python application ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

    sub_step "spack install ${build_target} ${myCompiler} ${myPython}"
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}

              echo "spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}

export build_target="py-virtualenv"
new_step "Build python application ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}"
              spack spec ${build_target} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

<<<<<<< Updated upstream
    sub_step "spack install ${build_target} ${myCompiler} ${myPython}"
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}
              echo "spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target} ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}
=======
    sub_step "spack install ${build_target} ${myCompiler} ${myPython} ${myOpenMPI}"
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}
              echo "spack install ${build_target} ${myCompiler} ${myPython} ${myOpenMPI} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target} ${myCompiler} ${myPython} ${myOpenMPI} 2>&1 | tee -a ${dlogs}/${fileName}
>>>>>>> Stashed changes

export build_target="py-astropy"
new_step "Build python application ${build_target}"
export sub_step_counter=0
fileName="${build_target}.txt"
    sub_step "spack spec ${build_target}+extras ${myPython}"
              spack spec ${build_target}+extras ${myPython} > ${SPACK_ROOT}/${USER}/specs/${fileName} &

    sub_step "spack info ${build_target}"
              spack info ${build_target} > ${SPACK_ROOT}/${USER}/info/${fileName} &

    sub_step "spack install ${build_target}+extras ${myCompiler} ${myPython}"
              date                      > ${dlogs}/${fileName}
              echo "${BASH_SOURCE[0]}" >> ${dlogs}/${fileName}
              echo "spack install ${build_target}+extras ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}"
                    spack install ${build_target}+extras ${myCompiler} ${myPython} 2>&1 | tee -a ${dlogs}/${fileName}

wait

export master=$((${SECONDS}-${master}))
printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
