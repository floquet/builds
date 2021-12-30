#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# start the timer
export mySECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export timerFile="${dirDockerLocker}/unified/timers/${platform}-${machine}-${owner}-${dist}-${release}-compilers-gcc.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

#export   gcc_default="gcc@10.1.1"  # fedora
export   gcc_default=${1}  # xiuhcoatl
export compilers_gcc="gcc@9.3.0 gcc@8.4.0 gcc@7.5.0 gcc@6.5.0 gcc@5.5.0 gcc@4.9.4 gcc@4.8.5"
# export compilers_gcc="gcc@10.2.0 gcc@9.3.0 gcc@8.4.0"

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

for c in ${compilers_gcc}; do
    export dirDebug="${dirDockerLocker}/unified/debug/${dist}/${release}/${1}"
    mkdir -p ${dirDebug}
    export logFile="${dirDebug}/${c}.log";
    date                >  ${logFile}
    echo ""             >> ${logFile}
    cat /etc/os-release >> ${logFile}
    echo ""             >> ${logFile}
    new_step "spack install ${c} % ${gcc_default} ${this_arch} >> ${logFile}"
              spack install ${c} % ${gcc_default} ${this_arch} >> ${logFile}
    new_step "spack compiler find $(spack location -i ${c} ${this_arch})"
              spack compiler find $(spack location -i ${c} ${this_arch})
done

new_step "time used = ${mySECONDS} s"
date    >  "${timerFile}"
echo "" >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for all gcc compilers: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))  >> "${timerFile}"
printf 'time for all gcc compilers: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))

date
