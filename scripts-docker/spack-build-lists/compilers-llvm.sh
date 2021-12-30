#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Mon Nov  1 12:18:11 MDT 2021

# start the timer
export mySECONDS=$SECONDS
# timestamp results
export             ymd=$(date +%Y-%m-%d-%H-%M)
export dirTimerFile="${dirTimerLog}/unified/timers/${owner}/${dist}/${release}";
export    timerFile="${dirTimerFile}/compilers-llvm.txt";

mkdir -p ${dirTimerFile}

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export    gcc_default=${1}  # fedora
export python_version="python@3.8.12"
export python_version="${python_default}"
export compilers_llvm="13.0.0 12.0.1 11.1.0"
#export compilers_llvm="llvm@10.0.1 llvm@9.0.1 llvm@8.0.0"

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

# enter spack directory to prepare for builds
export this_arch="arch=$(spack arch)"
new_step "\${this_arch} = ${this_arch}"

for c in ${compilers_llvm}; do
    export logFile="${dirBuildLog}/llvm@${c}.log";
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${logFile}
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${timerFile}

    tick=SECONDS
    new_step "spack install llvm@${c} % ${gcc_default} ^${python_version} ${this_arch} >> ${logFile} 2>&1"
              spack install llvm@${c} % ${gcc_default} ^${python_version} ${this_arch} >> ${logFile} 2>&1
    new_step "spack compiler find $(spack location -i llvm@${c} ${this_arch}) >> ${logFile} 2>&1"
              spack compiler find $(spack location -i llvm@${c} ${this_arch}) >> ${logFile} 2>&1
    let time="SECONDS-tick"
    printf '\ntime for "llvm@${c}"" compiler: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
done

new_step "time used to build llvms = ${mySECONDS} s"
d# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
let time="SECONDS-mySECONDS"
printf 'time for llvm compilers: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
printf 'time for llvm compilers: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60))

date
