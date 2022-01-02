#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# define: new_step
# define: sub_step
# define: spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
source ${repo_scripts_docker}/spack-build-out/master-header.zsh

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

#  #  ========================================================= declarations end

export myarch="arch=$(spack arch)"
new_step "\${myarch} = ${myarch}"

#  #  ========================================================= compilers

new_step "install gcc compilers"
export cmd_line=" % ${my_compiler} ${myarch} "
export list=("gcc@11.2.0" "gcc@10.3.0" "gcc@9.4.0" "gcc@8.5.0")
sweeper

new_step "install llvm compilers"
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
declare -a list=("llvm@13.0.0" "llvm@12.0.1" "llvm@11.1.0")
sweeper

#  #  ========================================================= py-myapp % ${my_compiler} ^${my_python}

new_step "install pattern - py-myapp % ${my_compiler} ^${my_python}: ${#lalpha[@]} elements"
declare -a list=("py-seaborn" "astropy" "py-beautifulsoup4" "py-tqdm" "py-urllib3" "py-gnuplot" "py-plotly" "py-bokeh" "py-geoplot" "py-leather" "py-h5netcdf" "py-netcdf4" "py-virtualenv")
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ${myarch}: ${#lbravo[@]} elements"
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
declare -a list=("blitz" "gdb" "gdl" "julia" "mpich" "openspeedshop" "rust" "vapor")
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ^${my_ompi}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ^${my_ompi}: ${#lcharlie[@]} elements"
export cmd_line=" % ${my_compiler} ^${my_python} ^${my_ompi} ${myarch} "
declare -a list=("tau" "trilinos" "vtk")
sweeper

#  #  ========================================================= myapp % ${my_compiler} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ${myarch}: ${#ldelta[@]} elements"
export cmd_line=" % ${my_compiler} ${myarch} "
declare -a list=("armadillo" "avizo" "eigen" "environment-modules" "gsl" "lua" "mpc" "mpich" "totalview" "xerces-c")
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_ompi} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ^${my_ompi} ${myarch}: ${#lecho[@]} elements"
export cmd_line=" % ${my_compiler} ^${my_ompi} ${myarch} "
declare -a list=("fftw" "netcdf-c" "netcdf-cxx" "netcdf-fortran" "opencoarrays" "valgrind" "zoltan")
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm}: ${#lfoxtrot[@]} elements"
export cmd_line=" % ${my_compiler} ^${my_python} ^${my_ompi} ^${my_llvm} ${myarch} "
declare -a list=("paraview" "petsc" "visit")
sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_ompi} ^${my_llvm}

new_step "install pattern - myapp % ${my_compiler} ^${my_ompi} ^${my_llvm}"
export cmd_line=" % ${my_compiler} ^${my_ompi} ^${my_llvm} ${myarch} "
declare -a list=("strumpack")
sweeper

#  #  ========================================================= fin

echo ""
echo "waiting for threads to complete..."
wait

echo ""
new_step "print wall time used"
export masterSECONDS=$((${SECONDS}-${masterSECONDS}))
printf 'time for all builds: %dh:%dm:%ds\n' $(($masterSECONDS/3600)) $(($masterSECONDS%3600/60)) $(($masterSECONDS%60))
