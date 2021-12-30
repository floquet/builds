#!/bin/zsh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results
export            yo="${platform}-${machine}-${owner}-${dist}-${release}"
export     timerFile="${dirDockerLocker}/unified/timers/${yo}-generic-spack-assembler.txt";
export       tplFile="${dirDockerLocker}/unified/build-logs/${yo}-tpls.txt";
export compilersFile="${dirDockerLocker}/unified/build-logs/${yo}-compilers.txt";
export    configFile="${dirDockerLocker}/unified/build-logs/${yo}-configuration.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export default_compiler=${1}

new_step "source ${dirDockerLocker}/unified/spack/compilers-gcc.zsh  ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/compilers-gcc.zsh  ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/pythons.zsh        ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/pythons.zsh        ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/compilers-llvm.zsh ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/compilers-llvm.zsh ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/tpls.zsh           ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/tpls.zsh           ${default_compiler}

new_step "Record build results"
date                              >  "${tplFile}"
echo ""                           >> "${tplFile}"
echo "SPACK_ROOT = ${SPACK_ROOT}" >> "${tplFile}"
echo ""                           >> "${tplFile}"
spack find                        >> "${tplFile}"

date                              >  "${compilersFile}"
echo ""                           >> "${compilersFile}"
echo "SPACK_ROOT = ${SPACK_ROOT}" >> "${compilersFile}"
echo ""                           >> "${compilersFile}"
spack compilers                   >> "${compilersFile}"
echo ""                           >> "${compilersFile}"
spack config blame compilers      >> "${compilersFile}"

date                              >  "${configFile}"
echo ""                           >> "${configFile}"
echo "SPACK_ROOT = ${SPACK_ROOT}" >> "${configFile}"
echo ""                           >> "${configFile}"

new_step "total time used"
date    >  "${timerFile}"
echo "" >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds
printf 'time for all build suites: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))  >> "${timerFile}"

date
