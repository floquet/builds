#!/bin/zsh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# dantopa:spack/topa % date
# Mon Nov 22 18:59:50 MST 2021
# dantopa:spack/topa % uname -a
# Darwin Xiuhcoatl.local 21.1.0 Darwin Kernel Version 21.1.0: Wed Oct 13 17:33:23 PDT 2021; root:xnu-8019.41.5~1/RELEASE_X86_64 x86_64

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

new_step "declarations"

export    compiler="gcc@9.4.0"
export python_tpls=(py-numpy py-pandas py-scipy py-urllib3 py-beautifulsoup4 py-tqdm py-pip)

new_step "spack load ${compiler}"
          spack load ${compiler}

export click=0
for t in ${python_tpls}; do
    click=$((click+1))
    new_step "spack install ${t} % ${compiler}"
              spack install ${t} % ${compiler}
done

printf 'time for all %s builds: %dh:%dm:%ds\n' ${click} $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

