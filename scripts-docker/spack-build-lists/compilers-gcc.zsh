#! /bin/#!/usr/bin/env zsh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# create timestamp variable ymdt, add functions for new_step, sub_step
source ${repo_build}/scripts-spack/shared/common-header.zsh

export compilers_gcc_seconds=0

export timerFile="${dirDockerLocker}/unified/timers/${platform}-${machine}-${owner}-${dist}-${release}-compilers-gcc.txt";
export   gcc_default=${1}
# export compilers_gcc=(gcc@10.2.0 gcc@9.3.0 gcc@8.4.0 gcc@7.5.0 gcc@6.5.0 gcc@5.5.0 gcc@4.9.4 gcc@4.8.5)
declare -a compilers_gcc=("gcc@11.2.0" "gcc@10.3.0" "gcc@9.4.0" "gcc@8.5.0")

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

new_step "building ${#compilers_gcc[@]} gcc compilers (${compilers_gcc})..."
for c in ${compilers_gcc[@]}; do
    new_step "spack install ${c} % ${gcc_default} ${this_arch}"
              spack install ${c} % ${gcc_default} ${this_arch}
    new_step "spack compiler find $(spack location -i ${c})"
              spack compiler find $(spack location -i ${c})
done

# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for all gcc compilers: %dh:%dm:%ds\n' $(($compilers_gcc_seconds/3600)) $(($compilers_gcc_seconds%3600/60)) $(($compilers_gcc_seconds%60))  >> "${timerFile}"

date
