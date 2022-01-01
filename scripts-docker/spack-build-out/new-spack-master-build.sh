#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# define: new_step
# define: sub_step
# define: spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
source ${repo_scripts_docker}/spack-build-out/master-header.sh

# spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}

#  #  ========================================================= declarations start

export masterSECONDS=$SECONDS

# https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
#export my_compiler="gcc@8.5.0-4.0.1"
export my_compiler="${gcc_system_compiler}"
export   my_python="python@3.10.1"
export     my_ompi="openmpi@4.1.2"
export     my_llvm="llvm@13.0.0"

# when using a spack-built compiler:
# spack load gcc @ 11.2.1

export blogs="${SPACK_ROOT}/${USER}/build-logs"
export bspec="${SPACK_ROOT}/${USER}/specs"

# py-${p} % ${my_compiler} ^${my_python}
declare -a   lalpha=("seaborn" "astropy" "beautifulsoup4" "tqdm" "urllib3" "gnuplot" "plotly" "bokeh" "geoplot" "leather" "h5netcdf" "netcdf4" "virtualenv")
# ${p} % ${my_compiler} ^${my_python}
declare -a   lbravo=("blitz" "gdb" "gdl" "julia" "mpich" "openspeedshop" "rust" "vapor")
# ${p} % ${my_compiler} ^${my_python} ^${my_ompi}
declare -a lcharlie=("tau" "trilinos" "vtk")
# ${p} % ${my_compiler}
declare -a   ldelta=("armadillo" "avizo" "eigen" "environment-modules" "gsl" "lua" "mpc" "mpich" "totalview" "xerces-c")
# ${p} % ${my_compiler} ^${my_ompi}
declare -a    lecho=("fftw" "netcdf-c" "netcdf-cxx" "netcdf-fortran" "opencoarrays" "valgrind" "zoltan")
# ${p} % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm}
declare -a  lfoxtrot=("paraview" "petsc" "visit")
# ${p} % ${my_compiler} ^${my_ompi} ^${my_llvm}
declare -a     lgulf=("strumpack")

# compilers
declare -a  lgcc=("11.2.0" "10.3.0" "9.4.0" "8.5.0")
declare -a lllvm=("13.0.0" "12.0.1" "11.1.0")

#  #  ========================================================= declarations end

export myarch="arch=$(spack arch)"
new_step "\${myarch} = ${myarch}"

#  #  ========================================================= compilers

new_step "install gcc compilers: ${#lgcc[@]} versions"
echo "\${lgcc[@]} = ${lgcc[@]}"
export  clicker=0
export cmd_line=" % ${my_compiler} ${myarch} "
for g in ${lgcc[@]}; do
    export  log_file="${blogs}/gcc-${g}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion "gcc@${g}" \${cmd_line} \${log_file} \${spec_file}

    sub_step "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i gcc@${g} % ${my_compiler})"
              spack compiler find $(spack location -i gcc@${g} % ${my_compiler}) &
done

new_step "install llvm compilers: ${#lllvm[@]} versions"
echo "\${lllvm[@]} = ${lllvm[@]}"
export clicker=0
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
for l in ${lllvm[@]}; do
    export  log_file="${blogs}/gcc-${v}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion "llvm@${l}" \${cmd_line} \${log_file} \${spec_file}

    sub_step "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
    echo     "spack compiler find $(spack location -i llvm@${l} % ${my_compiler})"
              spack compiler find $(spack location -i llvm@${l} % ${my_compiler}) &
done

#  #  ========================================================= py-myapp % ${my_compiler} ^${my_python}

new_step "install pattern - py-myapp % ${my_compiler} ^${my_python}: ${#lalpha[@]} elements"
echo "\${lalpha[@]} = ${lalpha[@]}"
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
export list=${lalpha[@]}
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ${myarch}: ${#lbravo[@]} elements"
echo "\${lbravo[@]} = ${lbravo[@]}"
export clicker=0
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
for p in ${lbravo[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ^${my_ompi}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ^${my_ompi}: ${#lcharlie[@]} elements"
echo "\${lcharlie[@]} = ${lcharlie[@]}"
export  clicker=0
export cmd_line=" % ${my_compiler} ^${my_python} ^${my_ompi} ${myarch} "
for p in ${lcharlie[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= myapp % ${my_compiler} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ${myarch}: ${#ldelta[@]} elements"
echo "\${ldelta[@]} = ${ldelta[@]}"
export  clicker=0
export cmd_line=" % ${my_compiler} ${myarch} "
for p in ${ldelta[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= myapp % ${my_compiler} ^${my_ompi} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ^${my_ompi} ${myarch}: ${#lecho[@]} elements"
export  clicker=0
export cmd_line=" % ${my_compiler} ^${my_ompi} ${myarch} "
for p in ${lecho[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm}: ${#lfoxtrot[@]} elements"
echo "\${lfoxtrot[@]} = ${lfoxtrot[@]}"
export  clicker=0
export cmd_line=" % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm} ${myarch} "
for p in ${lcharlie[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= myapp % ${my_compiler} ^${my_ompi} ^${my_llvm}

new_step "install pattern - myapp % ${my_compiler} ^${my_ompi} ^${my_llvm}: ${#lfoxtrot[@]} elements"
echo "\${lgulf[@]} = ${lgulf[@]}"
export  clicker=0
export cmd_line=" % ${my_compiler} ^${my_ompi} ^${my_llvm} ${myarch} "
for p in ${lgulf[@]}; do
    export  log_file="${blogs}/${p}.txt"
    export spec_file="${bspec}/${p}.txt"
    spacktion \${p} \${cmd_line} \${log_file} \${spec_file}
done

#  #  ========================================================= fin

echo ""
echo "waiting for threads to complete..."
wait

echo ""
new_step "print wall time used"
export masterSECONDS=$((${SECONDS}-${masterSECONDS}))
printf 'time for all builds: %dh:%dm:%ds\n' $(($masterSECONDS/3600)) $(($masterSECONDS%3600/60)) $(($masterSECONDS%60))
