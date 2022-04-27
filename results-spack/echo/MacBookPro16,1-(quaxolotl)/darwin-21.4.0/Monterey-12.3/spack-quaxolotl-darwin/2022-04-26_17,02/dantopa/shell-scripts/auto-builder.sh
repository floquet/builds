#!/bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export clicker=0
function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo " ${counter}.${clicker}: ${1}"
}

# https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
#export my_compiler="gcc@8.5.0-4.0.1"
export my_compiler="${gcc_system_compiler}"
export   my_python="python@3.10.1"
export     my_ompi="openmpi@4.1.2"

export blogs="${SPACK_ROOT}/dantopa/build-logs"
export bspec="${SPACK_ROOT}/dantopa/specs"

export SECONDS=0

# when using a spack-built compiler:
# spack load gcc @ 11.2.1

# py-${p} % ${my_compiler} ^${my_python}
declare -a   lalpha=("seaborn" "astropy" "beautifulsoup4" "tqdm" "urllib3" "gnuplot" "plotly" "bokeh" "geoplot" "leather" "h5netcdf" "netcdf4" "virtualenv")
# ${p} % ${my_compiler} ^${my_python}
declare -a   lbravo=("blitz" "gdb" "gdl" "julia" "mpich" "openspeedshop" "rust" "vapor" "visit")
# ${p} % ${my_compiler} ^${my_python} ^${my_ompi}
declare -a lcharlie=("paraview" "petsc" "strumpack" "tau" "trilinos" "vtk")
# ${p} % ${my_compiler}
declare -a   ldelta=("armadillo" "avizo" "eigen" "environment-modules" "gsl" "lua" "mpc" "mpich" "totalview" "xerces-c")
# ${p} % ${my_compiler} ^${my_ompi}
declare -a    lecho=("fftw" "netcdf-c" "netcdf-cxx" "netcdf-fortran" "opencoarrays" "valgrind" "zoltan")

# compilers
declare -a  lgcc=("11.2.0" "10.3.0" "9.4.0" "8.5.0")
declare -a lllvm=("13.0.0" "12.0.1" "11.1.0")

new_step "install pattern: py-myapp % ${my_compiler} ^${my_python}: ${#lalpha[@]} elements"
clicker=0
for p in ${lalpha}; do
    export log_file="${blogs}/py-${p}.txt"
    sub_step "spack install py-${p} % ${my_compiler} ^${my_python}  > ${log_file}"
    echo     "spack install py-${p} % ${my_compiler} ^${my_python}" > ${log_file}
            ##spack install py-${p} % ${my_compiler} ^${my_python} >> ${log_file} 2>&1
              spack spec    py-${p} % ${my_compiler} ^${my_python}  > "${bspec}/${p}.txt" &
done

new_step "install pattern: myapp % ${my_compiler} ^${my_python}: ${#lbravo[@]} elements"
clicker=0
for p in ${lbravo}; do
    export log_file="${blogs}/${p}.txt"
    sub_step "spack install ${p} % ${my_compiler} ^${my_python}  > ${log_file}"
    echo     "spack install ${p} % ${my_compiler} ^${my_python}" > ${log_file}
            ##spack install ${p} % ${my_compiler} ^${my_python} >> ${log_file} 2>&1
              spack spec    ${p} % ${my_compiler} ^${my_python} > "${bspec}/${p}.txt" &
done

new_step "install pattern: myapp % ${my_compiler} ^${my_python} ^${my_ompi}: ${#lcharlie[@]} elements"
clicker=0
for p in ${lcharlie}; do
    export log_file="${blogs}/${p}.txt"
    sub_step "spack install ${p} % ${my_compiler} ^${my_python} ^${my_ompi}  > ${log_file}"
    echo     "spack install ${p} % ${my_compiler} ^${my_python} ^${my_ompi}" > ${log_file}
            ##spack install ${p} % ${my_compiler} ^${my_python} ^${my_ompi} >> ${log_file} 2>&1
              spack spec    ${p} % ${my_compiler} ^${my_python} ^${my_ompi} > "${bspec}/${p}.txt" &
done

new_step "install pattern: myapp % ${my_compiler}: ${#ldelta[@]} elements"
clicker=0
for p in ${ldelta}; do
    echo ""
    export log_file="${blogs}/${p}.txt"
    sub_step "spack install ${p} % ${my_compiler}  > ${log_file}"
    echo     "spack install ${p} % ${my_compiler}" > ${log_file}
            ##spack install ${p} % ${my_compiler} >> ${log_file} 2>&1
              spack spec    ${p} % ${my_compiler} > "${bspec}/${p}.txt" &
done

new_step "install pattern: myapp % ${my_compiler} ^${my_ompi}: ${#lecho[@]} elements"
clicker=0
for p in ${lecho}; do
    echo ""
    export log_file="${blogs}/${p}.txt"
    sub_step "spack install ${p} % ${my_compiler} ^${my_ompi}  > ${log_file}"
    echo     "spack install ${p} % ${my_compiler} ^${my_ompi}" > ${log_file}
            ##spack install ${p} % ${my_compiler} ^${my_ompi} >> ${log_file} 2>&1
              spack spec    ${p} % ${my_compiler} ^${my_ompi} > "${bspec}/${p}.txt" &
done

new_step "install gcc compilers: ${#lgcc[@]} versions"
clicker=0
for g in ${lgcc}; do
    export log_file="${blogs}/gcc-${g}.txt"
    sub_step "spack install gcc@${g} % ${my_compiler}  > ${log_file}"
    echo     "spack install gcc@${g} % ${my_compiler}" > ${log_file}
            ##spack install gcc@${g} % ${my_compiler} >> ${log_file} 2>&1
              spack spec    gcc@${g} % ${my_compiler} > "${bspec}/gcc@${g}.txt" &
    echo ""
    sub_step "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})" &
             ##spack compiler find $(spack location -i gcc@${g} % ${my_compiler}) &
done

new_step "install llvm compilers: ${#lllvm[@]} versions"
clicker=0
for l in ${lllvm}; do
    export log_file="${blogs}/gcc-${v}.txt"
    sub_step "spack install llvm@${l} % ${my_compiler} ^${my_python}  > ${log_file}"
    echo     "spack install llvm@${l} % ${my_compiler} ^${my_python}" > ${log_file}
            ##spack install llvm@${l} % ${my_compiler} ^${my_python} >> ${log_file} 2>&1
              spack spec    llvm@${l} % ${my_compiler} ^${my_python} > "${bspec}/llvm@${l}.txt" &
    echo ""
    sub_step "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
            ##spack compiler find $(spack location -i llvm@${l} % ${my_compiler}) &
done

echo "waiting for threads to complete..."
wait

echo ""
new_step "print wall time used"
printf 'time for all builds: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

