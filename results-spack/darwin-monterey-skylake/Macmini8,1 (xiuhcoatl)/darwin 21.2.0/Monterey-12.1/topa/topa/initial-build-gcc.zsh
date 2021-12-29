#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${(%):-%N}$(tput sgr0)"
# Sat Oct 16 17:39:21 MDT 2021

# start the timer
export SECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export masterSpack="/Volumes/spacktivity/spack";
export timerFile="${masterSpack}/topa/timers/compilers-gcc-${ymd}.txt";
date > "${timerFile}"
echo ""              >> "${timerFile}"
echo "Spack folder:" >> "${timerFile}"
echo "${SPACK_ROOT}" >> "${timerFile}"

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export compilers_gcc=(gcc@11.2.0 gcc@10.3.0 gcc@9.4.0 gcc@8.5.0 gcc@4.8.5)

# activate spack
new_step "source ${masterSpack}/share/spack/setup-env.sh"
          source ${masterSpack}/share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"
echo ""                    >> "${timerFile}"
echo "spack architecture:" >> "${timerFile}"
echo "$(spack arch)"       >> "${timerFile}"
echo ""                    >> "${timerFile}"

for c in ${compilers_gcc}; do
    export mySECONDS=${SECONDS}
#    echo "\${mySECONDS} = ${mySECONDS}"
    new_step "spack install ${c} ${this_arch}"
              spack install ${c} ${this_arch}
    new_step "spack compiler find $(spack location -i ${c})"
              spack compiler find $(spack location -i ${c})
    export gccTIME=$(($SECONDS-$mySECONDS))
#    echo "\${gccTIME} = ${gccTime}"
    #echo "a = $(($SECONDS)-($mySECONDS))"
#    echo "b = $((($SECONDS-$mySECONDS)))"
#    echo "c = $(($SECONDS-$mySECONDS))"
printf 'time to install %s: %dh:%dm:%ds\n' ${c} $(($gccTIME/3600)) $(($gccTIME%3600/60)) $(($gccTIME%60))  >> "${timerFile}"
done

new_step "time used for all gcc compiler builds = ${SECONDS} s"
# https://stackoverflow.com/questions/12199631/convert-SECONDS-to-hours-minutes-SECONDS
printf '\ntime for all gcc compilers: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))  >> "${timerFile}"

date
