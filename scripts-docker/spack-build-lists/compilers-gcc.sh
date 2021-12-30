#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# start the timer
export mySECONDS=$SECONDS
# timestamp results
export          ymd=$(date +%Y-%m-%d-%H-%M)
export dirTimerFile="${dirTimerLog}/unified/timers/${owner}/${dist}/${release}";
export    timerFile="${dirTimerFile}/compilers-gcc.txt";

mkdir -p ${dirTimerFile}

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export   gcc_default=${1}  # xiuhcoatl
export compilers_gcc="11.2.0 10.3.0 9.4.0 8.5.0 7.5.0 6.5.0 5.5.0 4.9.4 4.8.5"
# export compilers_gcc="gcc@10.2.0 gcc@9.3.0 gcc@8.4.0"

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
export this_arch="arch=$(spack arch)"
new_step "\${this_arch} = ${this_arch}"

for c in ${compilers_gcc}; do
    export logFile="${dirBuildLog}/gcc@${c}.log";
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${logfile}
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${timerFile}

    tick=SECONDS
    new_step "spack install gcc@${c} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1"
        echo "spack install gcc@${c} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1"
              spack install gcc@${c} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1
    new_step "spack compiler find $(spack location -i gcc@${c} ${this_arch}) >> ${logFile} 2>&1"
        echo "spack compiler find $(spack location -i gcc@${c} ${this_arch}) >> ${logFile} 2>&1"
              spack compiler find $(spack location -i gcc@${c} ${this_arch}) >> ${logFile} 2>&1
    let time="SECONDS-tick"
    printf '\ntime for gcc@${c} compiler: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"

done

new_step "time used for gcc compiler builds"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
let time="SECONDS-mySECONDS"
printf 'time for all gcc compilers: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
printf 'time for all gcc compilers: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60))

date
