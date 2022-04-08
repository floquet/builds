#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/builders/centos-spack.sh

export master=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

# new_step "Set environment variables"
#   export myCompiler=" % gcc@11.2.0"
#   export myLLVM=" ^llvm@13.0.1"
#   export myOpenMPI=" ^openmpi@4.1.2"
#   export myPython=" ^python@3.10.2"
#   export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"
#
#   echo "\${myCompiler}  = ${myCompiler}"
#   echo "\${myLLVM}      = ${myLLVM}"
#   echo "\${myOpenMPI}   = ${myOpenMPI}"
#   echo "\${myPython}    = ${myPython}"
#   echo "\${mySpackLogs} = ${mySpackLogs}"

source ${SPACK_ROOT}/${USER}/shell-scripts/set-environment.sh

pause

# new_step "spack load gcc@11.2.0/i2xm6il"
#           spack load gcc@11.2.0/i2xm6il

new_step "Install packages"
spack_sub_step_counter=0

 spack_sub_step "spack install chapel ${myCompiler}"
           echo "spack install chapel ${myCompiler}" >>            ${mySpackLogs}/chapel.txt
                 spack install chapel ${myCompiler}  2>&1 | tee -a ${mySpackLogs}/chapel.txt

 spack_sub_step "spack install doxygen ${myCompiler} ${myPython}" 2>&1 | tee    ${mySpackLogs}/doxygen.txt
           spack install doxygen ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/doxygen.txt

 spack_sub_step "spack install environment-modules ${myCompiler}" 2>&1 | tee    ${mySpackLogs}/environment-modules.txt
           spack install environment-modules ${myCompiler}  2>&1 | tee -a ${mySpackLogs}/environment-modules.txt

 spack_sub_step "spack install gdb ${myCompiler} ${myPython}" 2>&1 | tee    ${mySpackLogs}/gdb.txt
           spack install gdb ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/gdb.txt

 spack_sub_step "spack install gsl ${myCompiler}" 2>&1 | tee    ${mySpackLogs}/gsl.txt
           spack install gsl ${myCompiler}  2>&1 | tee -a ${mySpackLogs}/gsl.txt

 spack_sub_step "spack install julia ${myCompiler} ${myLLVM}" 2>&1 | tee    ${mySpackLogs}/julia.txt
           spack install julia ${myCompiler} ${myLLVM}  2>&1 | tee -a ${mySpackLogs}/julia.txt

 spack_sub_step "spack install netcdf-fortran ${myCompiler} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/netcdf-fortran.txt
           spack install netcdf-fortran ${myCompiler} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/netcdf-fortran.txt

 spack_sub_step "spack install netcdf-cxx4 ${myCompiler} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/netcdf-cxx4.txt
           spack install netcdf-cxx4 ${myCompiler} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/netcdf-cxx4.txt

 spack_sub_step "spack install octave +arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib ${myCompiler} ${myPython} ${myLLVM}" 2>&1 | tee    ${mySpackLogs}/octave.txt
           spack install octave +arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib ${myCompiler} ${myPython} ${myLLVM}  2>&1 | tee -a ${mySpackLogs}/octave.txt

 spack_sub_step "spack install opencoarrays ${myCompiler} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/opencoarrays.txt
           spack install opencoarrays ${myCompiler} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/opencoarrays.txt

 spack_sub_step "spack install parallel-netcdf ${myCompiler} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/parallel-netcdf.txt
           spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/parallel-netcdf.txt

 spack_sub_step "spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/petsc.txt
           spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/petsc.txt

 spack_sub_step "spack install py-astropy+extras ${myCompiler} ${myPython}" 2>&1 | tee    ${mySpackLogs}/py-astropy.txt
           spack install py-astropy+extras ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-astropy.txt

 spack_sub_step "spack install py-seaborn ${myCompiler} ${myPython}" 2>&1 | tee    ${mySpackLogs}/py-seaborn.txt
           spack install py-seaborn ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-seaborn.txt

 spack_sub_step "spack install py-tqdm ${myCompiler} ${myPython}" 2>&1 | tee    ${mySpackLogs}/py-tqdm.txt
           spack install py-tqdm ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-tqdm.txt

 spack_sub_step "spack install py-urllib3 ${myCompiler} ${myPython}" 2>&1 | tee   ${mySpackLogs}/py-urllib3.txt
           spack install py-urllib3 ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-urllib3.txt

 spack_sub_step "spack install tau  ${myCompiler} ${myPython} ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/tau.txt
           spack install tau  ${myCompiler} ${myPython} ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/tau.txt

 spack_sub_step "spack install valgrind ${myCompiler}  ${myOpenMPI}" 2>&1 | tee    ${mySpackLogs}/valgrind.txt
           spack install valgrind ${myCompiler}  ${myOpenMPI}  2>&1 | tee -a ${mySpackLogs}/valgrind.txt

 spack_sub_step "spack install xcalc ${myCompiler}" 2>&1 | tee    ${mySpackLogs}/xcalc.txt
           spack install xcalc ${myCompiler}  2>&1 | tee -a ${mySpackLogs}/xcalc.txt

 spack_sub_step "spack install xerces-c ${myCompiler}" 2>&1 | tee    ${mySpackLogs}/xerces-c.txt
           spack install xerces-c ${myCompiler}  2>&1 | tee -a ${mySpackLogs}/xerces-c.txt

new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
