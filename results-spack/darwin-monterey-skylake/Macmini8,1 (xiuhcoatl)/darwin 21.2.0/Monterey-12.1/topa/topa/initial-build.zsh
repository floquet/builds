#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${(%):-%N}$(tput sgr0)"
# Sat Oct 16 17:39:21 MDT 2021

# start the timer
export mySECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export timerFile="/Volumes/spacktivity/spack/topa/timers/compilers-gcc-${ymd}.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export compilers_gcc=(gcc@11.2.0 gcc@10.3.0 gcc@9.4.0 gcc@8.5.0 gcc@4.8.5)

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

for c in ${compilers_gcc}; do
    new_step "spack install ${c} ${this_arch}"
              spack install ${c} ${this_arch}
    new_step "spack compiler find $(spack location -i ${c})"
              spack compiler find $(spack location -i ${c})
done

new_step "time used for gcc compiler builds = ${mySECONDS} s"
date                 >  "${timerFile}"
echo ""              >> "${timerFile}"
echo "${SPACK_ROOT}" >> "${timerFile}"
echo ""              >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for all gcc compilers: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))  >> "${timerFile}"

date
