#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/builders/master-builder.sh

export master=${SECONDS}

source ${repo_scripts_spack}/shared/common-header.sh

function spack_00(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler}"
    spack spec ${1} ${myCompiler} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}               > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1} ${myCompiler} 2>&1"      >> ${file}
                   spack install ${1} ${myCompiler} 2>&1 | tee -a ${file}
  }

function spack_01(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler} ${myPython}"
    spack spec ${1}${2} ${myCompiler} ${myPython} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}                               > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1}${2} ${myCompiler} ${myPython} 2>&1"      >> ${file}
                   spack install ${1}${2} ${myCompiler} ${myPython} 2>&1 | tee -a ${file}
  }

function spack_02(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler} ${myPython} ${myOpenMPI}"
    spack spec ${1}${2} ${myCompiler} ${myPython} ${myOpenMPI} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}                                            > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1}${2} ${myCompiler} ${myPython} ${myOpenMPI} 2>&1"      >> ${file}
                   spack install ${1}${2} ${myCompiler} ${myPython} ${myOpenMPI} 2>&1 | tee -a ${file}
  }

function spack_03(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler} ${myOpenMPI}"
    spack spec ${1}${2} ${myCompiler} ${myOpenMPI} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}                                > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1}${2} ${myCompiler} ${myOpenMPI} 2>&1"      >> ${file}
                   spack install ${1}${2} ${myCompiler} ${myOpenMPI} 2>&1 | tee -a ${file}
  }

function spack_04(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler} ${myLLVM}"
    spack spec ${1}${2} ${myCompiler} ${myLLVM} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}                             > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1}${2} ${myCompiler} ${myLLVM} 2>&1"      >> ${file}
                   spack install ${1}${2} ${myCompiler} ${myLLVM} 2>&1 | tee -a ${file}
  }

function spack_05(){
    sub_step_counter=$((sub_step_counter+1))
    echo "  ${step_counter}.${sub_step_counter}: spack install ${1} ${myCompiler} ${myPython} ${myLLVM}"
    spack spec ${1}${2} ${myCompiler} ${myPython} ${myLLVM} > "${SPACK_ROOT}/${USER}/specs/${1}.txt" &
    spack info ${1}                                         > "${SPACK_ROOT}/${USER}/info/${1}.txt"  &
    file="${SPACK_ROOT}/${USER}/build-logs/${1}.txt"
    echo "$(date): spack install ${1}${2} ${myCompiler} ${myPython} ${myLLVM} 2>&1"      >> ${file}
                   spack install ${1}${2} ${myCompiler} ${myPython} ${myLLVM} 2>&1 | tee -a ${file}
  }

new_step "Set environment variables"
  source ${SPACK_ROOT}/${USER}/shell-scripts/set-environment.sh

pause

# new_step "spack load gcc@11.2.0/i2xm6il"
#           spack load gcc@11.2.0/i2xm6il

new_step "application ${myCompiler}"
    sub_step_counter=0
    spack_00 "alglib"
    spack_00 "chapel"
    spack_00 "environment-modules"
    spack_00 "gsl"
    spack_00 "julia@1.7.2"
    spack_00 "xcalc"
    spack_00 "xerces-c"

new_step "application ${myCompiler} ${myPython}"
    sub_step_counter=0
    spack_01 "blitz"
    spack_01 "doxygen"
    spack_01 "gdb"
    spack_01 "gdl" "+python"
    spack_01 "mpich"
    spack_01 "py-astropy" "+extras"
    spack_01 "py-seaborn"
    spack_01 "py-tqdm"
    spack_01 "py-urllib3"
    spack_01 "rust"

new_step "application ${myCompiler} ${myPython} ${myOpenMPI}"
    sub_step_counter=0
    spack_02 "petsc" "+fftw +mpfr +mumps +scalapack +strumpack +suite-sparse +superlu-dist"
    spack_02 "tau"

new_step "application ${myCompiler} ${myOpenMPI}"
    sub_step_counter=0
    spack_03 "charmpp"
    spack_03 "h5bench"
    spack_03 "h5cpp"
    spack_03 "h5hut"
    spack_03 "h5part"
    spack_03 "hypre"
    spack_03 "netcdf-fortran"
    spack_03 "netcdf-cxx4"
    spack_03 "opencoarrays"
    spack_03 "parallel-netcdf"
    spack_03 "sprng" "+fortran"
    spack_03 "valgrind"
    spack_03 "zoltan"

# new_step "application ${myCompiler} ${myLLVM}"
#     sub_step_counter=0
#     spack_04 "julia"

new_step "application ${myCompiler} ${myPython} ${myLLVM}"
    sub_step_counter=0
    spack_05 "octave" "+arpack +fftw +gnuplot +hdf5 +llvm +qhull +suitesparse +zlib"

new_step "gcc compilers"
    sub_step_counter=0
    spack_00 "gcc@11.2.0"
    spack_00 "gcc@10.3.0"
    spack_00 "gcc@9.4.0"
    spack_00 "gcc@8.5.0"

new_step "add gcc compilers"
    sub_step_counter=0
    sub_step "spack compiler find $(location -i gcc@11.2.0)"
              spack compiler find $(location -i gcc@11.2.0)
    sub_step "spack compiler find $(location -i gcc@10.3.0)"
              spack compiler find $(location -i gcc@10.3.0)
    sub_step "spack compiler find $(location -i gcc@9.4.0)"
              spack compiler find $(location -i gcc@9.4.0)
    sub_step "spack compiler find $(location -i gcc@8.5.0)"
              spack compiler find $(location -i gcc@8.5.0)


new_step "llvm compilers"
    sub_step_counter=0
    spack_01 "llvm@13.0.1"
    spack_01 "llvm@12.0.1"
    spack_01 "llvm@11.1.0"

new_step "add gcc compilers"
    sub_step_counter=0
    sub_step "spack compiler find $(location -i llvm@13.0.1)"
              spack compiler find $(location -i llvm@13.0.1)
    sub_step "spack compiler find $(location -i llvm@12.0.1)"
              spack compiler find $(location -i llvm@12.0.1)
    sub_step "spack compiler find $(location -i llvm@11.1.0)"
              spack compiler find $(location -i llvm@11.1.0)


new_step "print wall time used"
  export master=$((${SECONDS}-${master}))
  printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
