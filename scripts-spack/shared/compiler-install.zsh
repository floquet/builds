#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"

# Wed Dec 29 18:20:31 MST 2021

# spack install compiler.new % compiler.used ^python arch=os-dist-cpu
#   1: compiler to build (gcc@11.2.0)
#   2: build compiler (% gcc@7.3.1; may be blank)
#   3: python version (^python@3.10.1)
#   4: spack arch (arch=arch=os-dist-cpu)
#   5: directory to post results
function spack_install_compiler(){
    sub_step "spack install ${1} ${2} ${3} ${4} | tee -a > ${5}"
              spack install ${1} ${2} ${3} ${4} | tee -a > ${5}
}

# enumerate substeps
function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo "  ${counter}.${clicker}: ${1}"
}
