#! /bin/#!/usr/bin/env zsh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# start the timer
export mySECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export timerFile="${dirDockerLocker}/unified/timers/${platform}-${machine}-${owner}-${dists}-${release}-compilers-llvm.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export    gcc_default=${1}  # fedora
export python_version="python@3.8.5"
#export    gcc_default="apple-clang@11.0.3"  # xiuhcoatl
#export compilers_llvm=(llvm@10.0.1 llvm@9.0.1 llvm@8.0.0 llvm@7.1.0)
export compilers_llvm=(llvm@10.0.1 llvm@9.0.1)

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

for c in ${compilers_llvm}; do
    new_step "spack install ${c} % ${gcc_default} ^${python_version} ${this_arch}"
              spack install ${c} % ${gcc_default} ^${python_version} ${this_arch}
    new_step "spack compiler find $(spack location -i ${c})"
              spack compiler find $(spack location -i ${c})
done

new_step "time used to build llvms = ${mySECONDS} s"
date                 >  "${timerFile}"
echo ""              >> "${timerFile}"
echo "${SPACK_ROOT}" >> "${timerFile}"
echo ""              >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for all llvm compilers: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))  >> "${timerFile}"

date
