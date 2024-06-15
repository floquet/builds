#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export myGCC="gcc@14.1.0"
export myCompiler=" % ${myGCC}"
export myClang="llvm@18.1.5"
export myLLVM=" ^${myClang}"
export myClangAlt="llvm@17.01.6"
export myOpenMPI=" ^openmpi@5.0.3"
export myPython=" ^python@3.11.7"
export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"

echo "\${myCompiler}  = ${myCompiler}"
echo "\${myLLVM}      = ${myLLVM}"
echo "\${myOpenMPI}   = ${myOpenMPI}"
echo "\${myPython}    = ${myPython}"
echo "\${mySpackLogs} = ${mySpackLogs}"

echo "spack load ${myGCC}"
      spack load ${myGCC}
