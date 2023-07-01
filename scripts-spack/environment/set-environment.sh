#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# $ cp ${repo_scripts_spack}/environment/set-environment.sh ${SPACK_ROOT}/${USER}/shell-scripts/.

export myCompiler=" % gcc@13.1.0"
# export myCompiler=" % gcc@11.2.0-19ubuntu1"
# export myCompiler=" % gcc@12.0.1"
# export  myCompiler=" % gcc@7.3.1"
export      myLLVM=" ^llvm@16.0.5"
export   myOpenMPI=" ^openmpi@4.1.5"
export    myPython=" ^python@3.11.2"
export mySpackLogs="${SPACK_ROOT}/${USER}"

echo "\${myCompiler}  = ${myCompiler}"
echo "\${myLLVM}      = ${myLLVM}"
echo "\${myOpenMPI}   = ${myOpenMPI}"
echo "\${myPython}    = ${myPython}"
echo "\${mySpackLogs} = ${mySpackLogs}"

echo "spack load gcc@13.1.0"
      spack load gcc@13.1.0
