#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# start the timer
export mySECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export timerFile="${dirDockerLocker}/unified/timers/${platform}-${machine}-${owner}-${dist}-${release}-python.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

#export   gcc_default="gcc@10.1.1"  # fedora
export    gcc_default=${1}  # xiuhcoatl
export python_default="python@3.8.5"
export python_verions=(${python_default} python@3.7.8 python@2.7.18 python@3.9.0)
# export    python_tpls=(py-astropy py-jupyter py-numpy py-pandas py-sympy py-scipy py-scientificpython py-xlsxwriter)
export    python_tpls=(py-jupyter py-numpy py-pandas py-sympy py-scipy py-xlsxwriter)

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

for p in ${python_verions}; do
    new_step "spack install ${p} % ${gcc_default} ${this_arch}"
              spack install ${p} % ${gcc_default} ${this_arch}
done

for t in ${python_tpls}; do
    new_step "spack install ${t} % ${gcc_default} ^${python_default} ${this_arch}"
              spack install ${t} % ${gcc_default} ^${python_default} ${this_arch}
done

new_step "time used for python installs = ${mySECONDS} s"
date                 >  "${timerFile}"
echo ""              >> "${timerFile}"
echo "${SPACK_ROOT}" >> "${timerFile}"
echo ""              >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for all python installs: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))  >> "${timerFile}"

date
