dantopa/base-amzn:${amzn_version} #! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/builders/base-build.sh

export master=${SECONDS}
export myCounter=0

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

spack_test(){
# https://stackoverflow.com/questions/4423306/how-do-i-find-the-number-of-arguments-passed-to-a-bash-script
    sub_step_counter=$((sub_step_counter+1))
    (( myCounter++ ))
    numArgs="$#"
    # echo "numArgs = ${numArgs}"
    # build command line
    cmdLine=""
    for var in "$@"
        do
            cmdLine+=${var} # append to command line
            (( count++ ))
            (( accum += ${#var} )) # number of characters
        done

    # remove blanks and special characters
    clean=$(echo "${cmdLine}" | tr -d ' ')
    clean=$(echo "${clean}"   | sed 's/\@/-/g')
    clean=$(echo "${clean}"   | sed 's/\^/-/g')
    clean=$(echo "${clean}"   | sed 's/\%/-/g')
    infoName="${1%@*}"
    # echo "\${cmdLine} = ${cmdLine}"
    # echo "\${clean} = ${clean}"
    echo ""
    echo "  ${step_counter}.${sub_step_counter}: spack install ${cmdLine}"
    # catalog basic information about the package: purpose, options, dependencies
    spack info "${infoName}" >>                 "${mySpackLogs}/info/${infoName}.txt" &
    # results of concretizer
    spack spec "${cmdLine}" >>                  "${mySpackLogs}/specs/${clean}.txt" &
    # install
    echo "$(date)"                  >>          "${mySpackLogs}/build-logs/${clean}.txt"
    echo "spack install ${cmdLine}" >>          "${mySpackLogs}/build-logs/${clean}.txt"
    export local=${master}
    spack install ${cmdLine} 2>&1 | tee -a      "${mySpackLogs}/build-logs/${clean}.txt"
    export local=$((${SECONDS}-${local}))
    printf "time to build ${1}: %dh:%dm:%ds\n" $((${local}/3600)) $((${local}%3600/60)) $((${local}%60)) >> "${mySpackLogs}/build-logs/${clean}.txt"
    echo ""                         >>           ${mySpackLogs}/build-logs/${clean}.txt
}

new_step "Verify environment variables"
  echo "\${myCompiler}  = ${myCompiler}"
  echo "\${myLLVM}      = ${myLLVM}"
  echo "\${myOpenMPI}   = ${myOpenMPI}"
  echo "\${myPython}    = ${myPython}"
  echo "\${mySpackLogs} = ${mySpackLogs}"

pause

new_step "Install compilers:"
spack_sub_step_counter=0

    #spack_test "gcc@11.2.0"  "${myCompiler}" "${myPython}"
    spack_test "llvm@14.0.0" "${myCompiler}" #"${myPython}"
    spack_test "llvm@13.0.1" "${myCompiler}" #"${myPython}"

    #spack compiler find $(spack location -i gcc@11.2.0)
    spack compiler find $(spack location -i llvm@14.0.0)
    spack compiler find $(spack location -i llvm@13.0.1)

wait

new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf "time for all ${myCounter} builds: %dh:%dm:%ds\n" $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
