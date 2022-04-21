dantopa/base-amzn:${amzn_version} #! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/builders/plus-build.sh

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

    clean=$(echo "${cmdLine}" | tr -d ' ')
    clean=$(echo "${clean}"   | sed 's/\^/-/g')
    clean=$(echo "${clean}"   | sed 's/\%/-/g')
    # echo "\${cmdLine} = ${cmdLine}"
    # echo "\${clean} = ${clean}"
    echo ""
    echo "  ${step_counter}.${sub_step_counter}: spack install ${cmdLine}"
    # catalog basic information about the package: purpose, options, dependencies
    spack info "${1}" >>                        "${mySpackLogs}/info/${1}.txt" &
    # results of concretizer
    spack spec "${cmdLine}" >>                  "${mySpackLogs}/specs/${clean}.txt" &
    # install
    echo "$(date)"                  >>          "${mySpackLogs}/build-logs/${1}.txt"
    echo "spack install ${cmdLine}" >>          "${mySpackLogs}/build-logs/${1}.txt"
    export local=${master}
    spack install ${cmdLine} 2>&1 | tee -a      "${mySpackLogs}/build-logs/${1}.txt"
    export local=$((${SECONDS}-${local}))
    printf "time to build ${1}: %dh:%dm:%ds\n" $((${local}/3600)) $((${local}%3600/60)) $((${local}%60)) >> "${mySpackLogs}/build-logs/${1}.txt"
    echo ""                         >>           ${mySpackLogs}/build-logs/${1}.txt
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

new_step "Install python tools"
spack_sub_step_counter=0

    spack_test "py-astropy" "+extras" "${myCompiler}" "${myPython}"
    spack_test "py-seaborn" "${myCompiler}" "${myPython}"
    spack_test "py-jupyter" "${myCompiler}" "${myPython}"
    spack_test "py-plotly" "${myCompiler}" "${myPython}"
    spack_test "py-virtualenv" "${myCompiler}" "${myPython}"

new_step "Install numeric tools"
spack_sub_step_counter=0

    spack_test "alglib" "${myCompiler}"
    spack_test "armadillo" "${myCompiler}"
    spack_test "arpack-ng" "${myCompiler}" "${myOpenMPI}"
    spack_test "blitz" "${myCompiler}" "${myPython}"
    spack_test "eigen" "${myCompiler}"
    spack_test "gsl" "${myCompiler}"
    spack_test "h5cpp" "${myCompiler}" "${myOpenMPI}"
    spack_test "hypre" "${myCompiler}" "${myOpenMPI}"
    spack_test "lapackpp" "${myCompiler}"
    spack_test "lis" "${myCompiler}" "${myOpenMPI}"
    spack_test "mpich" "${myCompiler}" "${myPython}"
    spack_test "netcdf-fortran" "${myCompiler}" "${myOpenMPI}"
    spack_test "netcdf-cxx4" "${myCompiler}" "${myOpenMPI}"
    spack_test "netlib-lapack" "${myCompiler}"
    spack_test "netlib-scalapack" "${myCompiler}"
    spack_test "octave" "+arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib" "${myCompiler}" "${myPython}"
    spack_test "petsc" "+fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist" "${myCompiler}" "${myPython}" "${myOpenMPI}"
    spack_test "opencoarrays" "${myCompiler}" "${myOpenMPI}"
    spack_test "parallel-netcdf" "${myCompiler}" "${myOpenMPI}"
    spack_test "root" "+fortran" "${myCompiler}" "${myPython}"
    spack_test "slepc" "${myCompiler}" "${myPython}"
    spack_test "sprng" "+fortran" "${myCompiler}" "${myOpenMPI}"

new_step "Install debug tools"
spack_sub_step_counter=0

    spack_test "gdb" "${myCompiler}" "${myPython}"
    spack_test "strace" "${myCompiler}"
    spack_test "tau" "${myCompiler}" "${myPython}" "${myOpenMPI}"
    spack_test "valgrind" "${myCompiler}"  "${myOpenMPI}"

new_step "Install languages:"
spack_sub_step_counter=0

    spack_test "chapel" "${myCompiler}"
    spack_test "julia" "${myCompiler}" "${myLLVM}"
    spack_test "lua" "${myCompiler}"
    spack_test "rust" "${myCompiler}" "${myPython}"

new_step "Install strays:"
spack_sub_step_counter=0

    spack_test "bashtop" "${myCompiler}"
    spack_test "graphviz" "${myCompiler}"
    spack_test "htop" "${myCompiler}" "${myPython}"
    spack_test "mpi-bash" "${myCompiler}" "${myOpenMPI}"
    spack_test "ninja" "${myCompiler}" "${myPython}"
    spack_test "ninja-fortran" "${myCompiler}" "${myPython}"
    spack_test "parallel" "${myCompiler}"
    spack_test "xcalc" "${myCompiler}"

# new_step "Install compilers:"
# spack_sub_step_counter=0
#
#     spack_test "gcc@11.2.0"  "${myCompiler}" "${myPython}"
#     spack_test "llvm@14.0.0" "${myCompiler}" "${myPython}"
#     spack_test "llvm@13.0.1" "${myCompiler}" "${myPython}"
#
#     spack compiler find $(spack location -i gcc@11.2.0)
#     spack compiler find $(spack location -i llvm@14.0.0)
#     spack compiler find $(spack location -i llvm@13.0.1)

wait

new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf "time for all ${myCounter} builds: %dh:%dm:%ds\n" $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
