#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export myCompiler=" % gcc@11.2.0"
# export myCompiler=" % gcc@12.0.1"
# export myCompiler=" % gcc@7.3.1"
export myLLVM=" ^llvm@13.0.1"
export myOpenMPI=" ^openmpi@4.1.2"
export myPython=" ^python@3.10.2"
export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"

echo "\${myCompiler}  = ${myCompiler}"
echo "\${myLLVM}      = ${myLLVM}"
echo "\${myOpenMPI}   = ${myOpenMPI}"
echo "\${myPython}    = ${myPython}"
echo "\${mySpackLogs} = ${mySpackLogs}"

echo "spack load gcc@11.2.0"
      spack load gcc@11.2.0

