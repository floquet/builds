#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export master=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

new_step "Set environment variables"
  export myCompiler=" % gcc@11.2.0"
  export myLLVM=" ^llvm@13.0.1"
  export myOpenMPI=" ^openmpi@4.1.2"
  export myPython=" ^python@3.10.2"
  export mySpackLogs="${SPACK_ROOT}/${USER}/build-logs"

  echo "\${myCompiler}  = ${myCompiler}"
  echo "\${myLLVM}      = ${myLLVM}"
  echo "\${myOpenMPI}   = ${myOpenMPI}"
  echo "\${myPython}    = ${myPython}"
  echo "\${mySpackLogs} = ${mySpackLogs}"

pause

new_step "spack load gcc@11.2.0/i2xm6il"
          spack load gcc@11.2.0/i2xm6il

new_step "Install packages"
 sub_step_counter=0

 sub_step "spack install chapel ${myCompiler}" | tee    ${mySpackLogs}/chapel.txt 2>&1
           spack install chapel ${myCompiler}  | tee -a ${mySpackLogs}/chapel.txt 2>&1

 sub_step "spack install doxygen ${myCompiler} ${myPython}" | tee    ${mySpackLogs}/doxygen.txt 2>&1
           spack install doxygen ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/doxygen.txt 2>&1

 sub_step "spack install environment-modules ${myCompiler}" | tee    ${mySpackLogs}/environment-modules.txt 2>&1
           spack install environment-modules ${myCompiler}  | tee -a ${mySpackLogs}/environment-modules.txt 2>&1

 sub_step "spack install gdb ${myCompiler} ${myPython}" | tee    ${mySpackLogs}/gdb.txt 2>&1
           spack install gdb ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/gdb.txt 2>&1

 sub_step "spack install gsl ${myCompiler}" | tee    ${mySpackLogs}/gsl.txt 2>&1
           spack install gsl ${myCompiler}  | tee -a ${mySpackLogs}/gsl.txt 2>&1

 sub_step "spack install julia ${myCompiler} ${myLLVM}" | tee    ${mySpackLogs}/julia.txt 2>&1
           spack install julia ${myCompiler} ${myLLVM}  | tee -a ${mySpackLogs}/julia.txt 2>&1

 sub_step "spack install netcdf-fortran ${myCompiler} ${myOpenMPI}" | tee    ${mySpackLogs}/netcdf-fortran.txt 2>&1
           spack install netcdf-fortran ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/netcdf-fortran.txt 2>&1

 sub_step "spack install netcdf-cxx4 ${myCompiler} ${myOpenMPI}" | tee    ${mySpackLogs}/netcdf-cxx4.txt 2>&1
           spack install netcdf-cxx4 ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/netcdf-cxx4.txt 2>&1

 sub_step "spack install octave +arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib ${myCompiler} ${myPython} ${myLLVM}" | tee    ${mySpackLogs}/octave.txt
           spack install octave +arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib ${myCompiler} ${myPython} ${myLLVM}  | tee -a ${mySpackLogs}/octave.txt

 sub_step "spack install opencoarrays ${myCompiler} ${myOpenMPI}" | tee    ${mySpackLogs}/opencoarrays.txt 2>&1
           spack install opencoarrays ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/opencoarrays.txt 2>&1

 sub_step "spack install parallel-netcdf ${myCompiler} ${myOpenMPI}" | tee    ${mySpackLogs}/parallel-netcdf.txt 2>&1
           spack install parallel-netcdf ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/parallel-netcdf.txt 2>&1

 sub_step "spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI}" | tee    ${mySpackLogs}/petsc.txt 2>&1
           spack install petsc +fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist ${myCompiler} ${myPython} ${myOpenMPI}  | tee -a ${mySpackLogs}/petsc.txt 2>&1

 sub_step "spack install py-astropy+extras ${myCompiler} ${myPython}" | tee    ${mySpackLogs}/py-astropy.txt
           spack install py-astropy+extras ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-astropy.txt

 sub_step "spack install py-seaborn ${myCompiler} ${myPython}" | tee    ${mySpackLogs}/py-seaborn.txt 2>&1
           spack install py-seaborn ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-seaborn.txt 2>&1

 sub_step "spack install py-tqdm ${myCompiler} ${myPython}" | tee    ${mySpackLogs}/py-tqdm.txt 2>&1
           spack install py-tqdm ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-tqdm.txt 2>&1

 sub_step "spack install py-urllib3 ${myCompiler} ${myPython}" | tee   ${mySpackLogs}/py-urllib3.txt 2>&1
           spack install py-urllib3 ${myCompiler} ${myPython}  | tee -a ${mySpackLogs}/py-urllib3.txt 2>&1

 sub_step "spack install opencoarrays ${myCompiler} ${myOpenMPI}" | tee    ${mySpackLogs}/opencoarrays.txt 2>&1
           spack install opencoarrays ${myCompiler} ${myOpenMPI}  | tee -a ${mySpackLogs}/opencoarrays.txt 2>&1

 sub_step "spack install tau  ${myCompiler} ${myPython} ${myOpenMPI}" | tee    ${mySpackLogs}/tau.txt 2>&1
           spack install tau  ${myCompiler} ${myPython} ${myOpenMPI}  | tee -a ${mySpackLogs}/tau.txt 2>&1

 sub_step "spack install valgrind ${myCompiler}  ${myOpenMPI}" | tee    ${mySpackLogs}/valgrind.txt 2>&1
           spack install valgrind ${myCompiler}  ${myOpenMPI}  | tee -a ${mySpackLogs}/valgrind.txt 2>&1

 sub_step "spack install xcalc ${myCompiler}" | tee    ${mySpackLogs}/xcalc.txt 2>&1"
           spack install xcalc ${myCompiler}  | tee -a ${mySpackLogs}/xcalc.txt 2>&1

 sub_step "spack install xerces-c ${myCompiler}" | tee    ${mySpackLogs}/xerces-c.txt 2>&1"
           spack install xerces-c ${myCompiler}  | tee -a ${mySpackLogs}/xerces-c.txt 2>&1

new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
