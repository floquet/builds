#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# define: new_step
# define: sub_step
# define: spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
source ${repo_results_docker}/spack-build-out/master-header.sh

#  #  ========================================================= declarations start

export SECONDS=0

# https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
#export my_compiler="gcc@8.5.0-4.0.1"
export my_compiler="${gcc_system_compiler}"
export   my_python="python@3.10.1"
export     my_ompi="openmpi@4.1.2"

# when using a spack-built compiler:
# spack load gcc @ 11.2.1

export blogs="${SPACK_ROOT}/dantopa/build-logs"
export bspec="${SPACK_ROOT}/dantopa/specs"

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

#  #  ========================================================= declarations end

export myarch="arch=$(spack arch)"
new_step "\${myarch} = ${myarch}"

new_step "install pattern: py-myapp % ${my_compiler} ^${my_python}: ${#lalpha[@]} elements"
clicker=0
for q in ${lalpha[@]}; do
    export p="py-${q}"
    export log_file="${blogs}/${p}.txt"
    export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
    spacktion ${p} ${cmd_line} ${log_file} ${bspec}
done

new_step "install pattern: myapp % ${my_compiler} ^${my_python} ${myarch}: ${#lbravo[@]} elements"
clicker=0
for p in ${lbravo[@]}; do
    export log_file="${blogs}/${p}.txt"
    export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
    spacktion ${p} ${cmd_line} ${log_file} ${bspec}
ddone

new_step "install pattern: myapp % ${my_compiler} ^${my_python} ^${my_ompi}: ${#lcharlie[@]} elements"
clicker=0
for p in ${lcharlie[@]}; do
    export log_file="${blogs}/${p}.txt"
    export cmd_line=" % ${my_compiler} ^${my_python} ^${my_ompi} ${myarch} "
    spacktion ${p} ${cmd_line} ${log_file} ${bspec}
done

new_step "install pattern: myapp % ${my_compiler} ${myarch}: ${#ldelta[@]} elements"
clicker=0
for p in ${ldelta[@]}; do
    export log_file="${blogs}/${p}.txt"
    export cmd_line=" % ${my_compiler} ${myarch} "
    spacktion ${p} ${cmd_line} ${log_file} ${bspec}
done

new_step "install pattern: myapp % ${my_compiler} ^${my_ompi} ${myarch}: ${#lecho[@]} elements"
for p in ${lecho[@]}; do
    export log_file="${blogs}/${p}.txt"
    export cmd_line=" % ${my_compiler} ^${my_ompi} ${myarch} "
    spacktion ${p} ${cmd_line} ${log_file} ${bspec}
done

new_step "install gcc compilers: ${#lgcc[@]} versions"
for g in ${lgcc[@]}; do
    export log_file="${blogs}/gcc-${g}.txt"
    export cmd_line=" % ${my_compiler} ^${my_ompi} ${myarch} "
    spacktion "gcc@${g}" ${cmd_line} ${log_file} ${bspec}

    sub_step "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})"
              spack compiler find $(spack location -i gcc@${g} % ${my_compiler}) &
done

new_step "install llvm compilers: ${#lllvm[@]} versions"
clicker=0
for l in ${lllvm[@]}; do
    export log_file="${blogs}/gcc-${v}.txt"
    export cmd_line=" % ${my_compiler} ^${my_ompi} ${myarch} "
    spacktion "llvm@${l}" ${cmd_line} ${log_file} ${bspec}

    sub_step "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
              spack compiler find $(spack location -i llvm@${l} % ${my_compiler}) &
done

echo ""
echo "waiting for threads to complete..."
wait

echo ""
new_step "print wall time used"
printf 'time for all builds: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))