#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export myCompiler=" % gcc@11.2.0"
export myLLVM=" ^llvm@13.0.0"
export myOpenMPI=" ^openmpi@4.1.2"
export myPython=" ^python@3.10.1"
export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"

