#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/builders/centos-spack.sh

export master=${SECONDS}

export mySpackLogs="/Volumes/spacktivity/xiuhcoatl-monterey-spack/dantopa"

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

spack_test(){
# https://stackoverflow.com/questions/4423306/how-do-i-find-the-number-of-arguments-passed-to-a-bash-script
    sub_step_counter=$((sub_step_counter+1))
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

    clean=$(echo "${cmdLine}" | tr -d ' ')
    clean=$(echo "${clean}"   | sed 's/\^/-/g')
    clean=$(echo "${clean}"   | sed 's/\%/-/g')
    # echo "\${cmdLine} = ${cmdLine}"
    # echo "\${clean} = ${clean}"
    echo ""
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1}"
    spack info "${1}" >> "${mySpackLogs}/info/${1}.txt" &
    spack spec "${cmdLine}" >> "${mySpackLogs}/spec/${clean}.txt" &
    echo "spack install ${cmdLine} 2>&1 | tee -a ${mySpackLogs}/build-logs/${1}.txt"
}

new_step "Verify environment variables"
  echo "\${myCompiler}  = ${myCompiler}"
  echo "\${myLLVM}      = ${myLLVM}"
  echo "\${myOpenMPI}   = ${myOpenMPI}"
  echo "\${myPython}    = ${myPython}"
  echo "\${mySpackLogs} = ${mySpackLogs}"

pause

new_step "Spack installs: "${myCompiler}""
spack_sub_step_counter=0

    spack_test "chapel" "${myCompiler}"
    spack_test "doxygen" "${myCompiler}" "${myPython}"
    spack_test "environment-modules" "${myCompiler}"
    spack_test "gdb" "${myCompiler}" "${myPython}"
    spack_test "gsl" "${myCompiler}"
    spack_test "julia" "${myCompiler}" "${myLLVM}"
    spack_test "netcdf-fortran" "${myCompiler}" "${myOpenMPI}"
    spack_test "netcdf-cxx4" "${myCompiler}" "${myOpenMPI}"
    spack_test "octave" "+arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib" "${myCompiler}" "${myPython}"
    spack_test "opencoarrays" "${myCompiler}" "${myOpenMPI}"
    spack_test "parallel-netcdf" "${myCompiler}" "${myOpenMPI}"
    spack_test "petsc" "+fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist" "${myCompiler}" "${myPython}" "${myOpenMPI}"
    spack_test "py-astropy" "+extras" "${myCompiler}" "${myPython}"
    spack_test "py-seaborn" "${myCompiler}" "${myPython}"
    spack_test "py-urllib3" "${myCompiler}" "${myPython}"
    spack_test "py-virtualenv" "${myCompiler}" "${myPython}"
    spack_test "tau" "${myCompiler}" "${myPython}" "${myOpenMPI}"
    spack_test 'valgrind' "${myCompiler}"  "${myOpenMPI}"
    spack_test "xcalc" "${myCompiler}"
    spack_test "xerces-c" "${myCompiler}"

wait

new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
