#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"

# Mon Dec 27 21:28:59 UTC 2021

# define: new_step
# define: sub_step
# define: spacktion ${p} ${cmd_arguments} ${log_file} ${bspec}
source ${repo_scripts_docker}/spack-build-out/beta/master-header.zsh

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

# py-${p} % ${my_compiler} ^${my_python}
declare -a   lalpha=("seaborn" "astropy" "beautifulsoup4" "tqdm" "urllib3" "gnuplot" "plotly" "bokeh" "geoplot" "leather" "h5netcdf" "netcdf4" "virtualenv")
# ${p} % ${my_compiler} ^${my_python}
declare -a   lbravo=("blitz" "gdb" "gdl" "julia" "mpich" "openspeedshop" "rust" "vapor")


# compilers
declare -a  lgcc=("11.2.0" "10.3.0" "9.4.0" "8.5.0")
declare -a lllvm=("13.0.0" "12.0.1" "11.1.0")

#  #  ========================================================= declarations end

export myarch="arch=$(spack arch)"
new_step "\${myarch} = ${myarch}"

#  #  ========================================================= compilers

# new_step "install gcc compilers: ${#lgcc[@]} versions"
# echo "\${lgcc[@]} = ${lgcc[@]}"
# export cmd_line=" % ${my_compiler} ${myarch} "
# export list=${lgcc[@]}
# sweeper
#
# new_step "install llvm compilers: ${#lllvm[@]} versions"
# echo "\${lllvm[@]} = ${lllvm[@]}"
# export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
# declare -a list=${lllvm[@]}
# sweeper
#
# #  #  ========================================================= py-myapp % ${my_compiler} ^${my_python}
#
# new_step "install pattern - py-myapp % ${my_compiler} ^${my_python}: ${#lalpha[@]} elements"
# echo "\${lalpha[@]} = ${lalpha[@]}"
# export list=$(echo "$lalpha" | sed 's/[^ ]* */py-&/g')
# export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
# sweeper

#  #  ========================================================= myapp % ${my_compiler} ^${my_python} ${myarch}

new_step "install pattern - myapp % ${my_compiler} ^${my_python} ${myarch}"
declare -a   list=("blitz" "gdb" "gdl" "julia" "mpich" "openspeedshop" "rust" "vapor")
export cmd_line=" % ${my_compiler} ^${my_python} ${myarch} "
sweeper

#  #  ========================================================= fin

echo ""
echo "waiting for threads to complete..."
wait

echo ""
new_step "print wall time used"
export masterSECONDS=$((${SECONDS}-${masterSECONDS}))
printf 'time for all builds: %dh:%dm:%ds\n' $(($masterSECONDS/3600)) $(($masterSECONDS%3600/60)) $(($masterSECONDS%60))
