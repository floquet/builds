#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/builders/centos-spack.sh

export master=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

spack_test(){
# https://stackoverflow.com/questions/4423306/how-do-i-find-the-number-of-arguments-passed-to-a-bash-script
    sub_step_counter=$((sub_step_counter+1))
    numArgs="$#"
    echo "numArgs = ${numArgs}"
    # build command line
    cmdLine=""
    for var in "$@"
        do
            cmdLine+=${var} # append to command line
            (( count++ ))
            (( accum += ${#var} )) # number of characters
        done

    clean=$(echo "${cmdLine}" | tr -d ' ')
    clean=$(echo "${clean}"   | sed 's/\^/-/g')
    clean=$(echo "${clean}"   | sed 's/\%/-/g')
    echo "\${cmdLine} = ${cmdLine}"
    echo "\${clean} = ${clean}"
    echo "spack info ${1} > ${mySpackLogs}/info/${1}.txt"
    echo "spack spec ${cmdLine}/spec/${1}.txt"
    echo "  ${step_counter}.${sub_step_counter}: spack install ${cmdLine}"
}

sub_step_counter=1

spack_test "octave" " +arpack +fftw" "${myCompiler}" "${myOpenMPI}"

spack_test "gcc" "@11.2.0" "${myCompiler}" "${myOpenMPI}"



new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
