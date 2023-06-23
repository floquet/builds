#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export myCompiler=" % gcc@13.1.0"
export myLLVM=" ^llvm@16.0.5"
export myOpenMPI=" ^openmpi@4.1.5"
export myPython=" ^python@3.10.10"
export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"

echo "\${myCompiler}  = ${myCompiler}"
echo "\${myLLVM}      = ${myLLVM}"
echo "\${myOpenMPI}   = ${myOpenMPI}"
echo "\${myPython}    = ${myPython}"
echo "\${mySpackLogs} = ${mySpackLogs}"

echo "spack load gcc@13.1.0"
      spack load gcc@13.1.0
