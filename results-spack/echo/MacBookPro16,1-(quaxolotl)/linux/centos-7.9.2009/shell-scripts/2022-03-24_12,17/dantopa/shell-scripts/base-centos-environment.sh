#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/base-centos-environment.sh
export master=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh
source ${SPACK_ROOT}/${USER}/shell-scripts/set-environment.sh

pause

echo "spack install gdb ${myCompiler} ${myPython} 2>&1 | tee -a ${mySpackLogs}/gdb.txt" >> ${mySpackLogs}/gdb.txt
      spack install gdb ${myCompiler} ${myPython} 2>&1 | tee -a ${mySpackLogs}/gdb.txt

echo "spack install tau ${myCompiler} ${myPython} ${myOpenMPI} 2>&1 | tee -a ${mySpackLogs}/tau.txt" >> ${mySpackLogs}/tau.txt
      spack install tau ${myCompiler} ${myPython} ${myOpenMPI} 2>&1 | tee -a ${mySpackLogs}/tau.txt

echo "spack install valgrind ${myCompiler} ${myOpenMPI} 2>&1 | tee -a ${SmySpackLogs}/valgrind.txt"  >> ${mySpackLogs}/valgrind.txt
      spack install valgrind ${myCompiler} ${myOpenMPI} 2>&1 | tee -a ${SmySpackLogs}/valgrind.txt


new_step "print wall time used"
    export master=$((${SECONDS}-${master}))
    printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
