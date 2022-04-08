#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export myCompiler=" % gcc@11.2.0"
export myLLVM=" ^llvm@13.0.1"
export myOpenMPI=" ^openmpi@4.1.2"
export myPython=" ^python@3.10.2"

spack_test(){
# https://stackoverflow.com/questions/4423306/how-do-i-find-the-number-of-arguments-passed-to-a-bash-script
    sub_step_counter=$((sub_step_counter+1))
    numArgs=$#
    echo "numArgs = ${numArgs}"
    echo "spack info ${1}"
    # build command line
    cmdLine=""
    for var in "$@"
        do
            cmdLine+=${var}
            (( count++ ))
            (( accum += ${#var} ))
        done

    echo "\${accum} = ${accum}"
    echo "  ${step_counter}.${sub_step_counter}: spack install ${cmdLine}"
}

    step_counter=1
sub_step_counter=1

spack_test "${myCompiler}" "${myOpenMPI}"

spack_test "octave" " +arpack +fftw" "${myCompiler}" "${myOpenMPI}"

spack_test "gcc" "@11.2.0" "${myCompiler}" "${myOpenMPI}"
