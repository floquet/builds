#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-spack/environment/master-spack-build.sh 

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

export master=${SECONDS}

new_step "Set environment variables: path"
    export    dirInfo="${SPACK_ROOT}/${USER}/info"
    export   dirSpecs="${SPACK_ROOT}/${USER}/specs"
    export dirScripts="${SPACK_ROOT}/${USER}/shell-scripts"
    export dirInstall="${SPACK_ROOT}/${USER}/build-logs"
    sub_step "\${dirInstall} = ${dirInstall}"
    sub_step "\${dirInfo}    = ${dirInfo}"
    sub_step "\${dirScripts} = ${dirScripts}"
    sub_step "\${dirSpecs}   = ${dirSpecs}"

new_step "Set environment variables: version"
source ${repo_scripts_spack}/environment/set-environment.sh
#     export myCompiler=" % gcc@14.1.0"
#     export     myLLVM="^llvm@17.0.6"
#     export  myOpenMPI="^openmpi@5.0.4"
#     export   myPython="^python@3.11.7"

    sub_step "\${myCompiler} = ${myCompiler}"
    sub_step "\${myLLVM}     = ${myLLVM}"
    sub_step "\${myOpenMPI}  = ${myOpenMPI}"
    sub_step "\${myPython}   = ${myPython}"

new_step "Create directory structure"
    sub_step "mkdir -p ${dirInstall}/build-logs"
              mkdir -p ${dirInstall}/build-logs
    sub_step "mkdir -p ${dirInfo}/info"
              mkdir -p ${dirInfo}/info
    sub_step "mkdir -p ${dirScripts}/shell-scripts"
              mkdir -p ${dirScripts}/shell-scripts
    sub_step "mkdir -p ${dirSpecs}/specs"
              mkdir -p ${dirSpecs}/specs

pause
  
new_step "spack build out"
    source ${repo_build}/scripts-spack/environment/slave-spack-build.sh

new_step "python builds"
    source ${repo_build}/scripts-spack/environment/slave-python-build.sh

new_step "print wall time used"
    export master=$((${SECONDS}-${master}))
    printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
