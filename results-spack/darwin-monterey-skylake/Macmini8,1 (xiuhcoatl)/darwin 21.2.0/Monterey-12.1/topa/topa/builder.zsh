#!/bin/zsh
printf '%s\n' "$(tput bold)$(date) ${HOME}/${(%):-%N} $(tput sgr0)"
# Fri Nov 26 18:08:16 MST 2021

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

#   #   #   #   #   #   #   #   #   #   #
export               compiler="apple-clang@13.0.0"
export         python_version="python@3.8.12"
export space_weather_packages=('py-seaborn' 'py-tqdm' 'py-urllib3' 'py-beautifulsoup4' 'py-gnuplot' 'py-plotly' 'py-bokeh' 'py-geoplot' 'py-leather' 'gdb' 'julia' 'petsc' 'rust' 'tau' 'trilinos')
export          gcc_compilers=('gcc@11.2.0' 'gcc@11.1.0' 'gcc@10.3.0' 'gcc@10.2.0' 'gcc@10.1.0' 'gcc@9.4.0' 'gcc@8.5.0')
export        clang_compilers=('llvm@13.0.0' 'llvm@12.0.1' 'llvm@11.1.0')
export                   tpls=('armadillo' 'chapel' 'go' 'gsl' 'valgrind')
new_step "Parameters: \${compiler} = ${compiler}; \${python_version} = ${python_version}"

export this_arch="arch=$(spack arch)"
new_step "\${this_arch} = ${this_arch}"

new_step "spack load ${compiler}"
          spack load ${compiler}

for p in ${space_weather_packages}; do
new_step "spack install ${p} % ${compiler} ^${python_version} ${this_arch}"
          spack install ${p} % ${compiler} ^${python_version} ${this_arch}
done

for p in ${gcc_compilers}; do
new_step "spack install ${p} % ${compiler} ${this_arch}"
          spack install ${p} % ${compiler} ${this_arch}
new_step "spack compiler find $(spack location -i ${p})"
          spack compiler find $(spack location -i ${p})
done

for p in ${clang_compilers}; do
new_step "spack install ${p} % ${compiler} ${this_arch}"
          spack install ${p} % ${compiler} ${this_arch}
new_step "spack compiler find $(spack location -i ${p})"
          spack compiler find $(spack location -i ${p})

new_step "spack find"
          spack find

new_step "pip install spacepy"
          pip install spacepy

new_step "print wall time used"
printf 'time for all builds: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

new_step "date"
          date


