#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 11 13:27:56 MST 2022

#  #  #  ========================================== declarations begin

# start timer
export prepSECONDS=${SECONDS}

# # layout of repositories
export github="/repos/github"
export dirBuilds="${github}/builds"

export dirScriptsDocker="${dirBuilds}/scripts-docker"
export  dirScriptsSpack="${dirBuilds}/scripts-spack"
export dirResultsDocker="${dirBuilds}/results-docker"
export dirResultsDocker="${dirBuilds}/results-spack"

# git configuration
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"

# git configuration
export dist="ubuntu"
export release="22.04"
export ldirSpack="${dist}-${release}-docker-spack"
export dirSpacktivity="${HOME}/spacktivity"

#  #  #  ========================================== declarations end

source ${dirScriptsSpack}/shared/common-header.sh

#  #  #  ========================================== configure git

new_step "Configure git"
sub_step_counter=0

    sub_step "git config --global pull.rebase false"
              git config --global pull.rebase false

    sub_step "git config --global user.name ${git_user}"
              git config --global user.name ${git_user}

    sub_step "git config --global user.email ${git_email}"
              git config --global user.email ${git_email}

    sub_step "git config --global pull.rebase false"
              git config --global pull.rebase false

    sub_step "git config --global push.default simple"
              git config --global push.default simple

    sub_step "git config --global color.ui true"
              git config --global color.ui true

    sub_step "git config --global rerere.enabled true"
              git config --global rerere.enabled true

    sub_step "git config --global merge.tool 'meld'"
              git config --global merge.tool 'meld'

    sub_step "git config --global core.editor 'vim'"
              git config --global core.editor 'vim'

#  #  #  ========================================== general directory structure

new_step "Create general directory structure"
sub_step_counter=0

  sub_step "cd ${HOME}"
            cd ${HOME}
  sub_step "mkdir -p ${HOME}/repos/bitbucket"
            mkdir -p ${HOME}/repos/bitbucket
  sub_step "mkdir -p ${HOME}/repos/github"
            mkdir -p ${HOME}/repos/github

#  #  #  ========================================== configure git

new_step "Environment variables"
sub_step_counter=0
  sub_step "export repos=${HOME}/repos/"
            export repos=${HOME}/repos/
  sub_step "export bitbucket=${repos}/bitbucket"
            export bitbucket=${repos}/bitbucket
  sub_step "export    github=${repos}/github"
            export    github=${repos}/github
  sub_step "export    github=${repos}/gitlab"
            export    github=${repos}/gitlab

#  #  #  ========================================== spack

new_step "Install spack"
sub_step_counter=0

    sub_step "mkdir -p ${dirSpacktivity}"
              mkdir -p ${dirSpacktivity}

    sub_step "cd ${dirSpacktivity}"
              cd ${dirSpacktivity}

    sub_step "git clone https://github.com/spack/spack ${ldirSpack}"
              git clone https://github.com/spack/spack ${ldirSpack}

    sub_step "cd ${ldirSpack}"
              cd ${ldirSpack}

    sub_step "mkdir -p ${USER}/build-logs"
              mkdir -p ${USER}/build-logs

    sub_step "mkdir -p ${USER}/specs"
              mkdir -p ${USER}/specs

    sub_step "mkdir -p ${USER}/info"
              mkdir -p ${USER}/info

    sub_step "mkdir -p ${USER}/shell-scripts"
              mkdir -p ${USER}/shell-scripts

    sub_step "source share/spack/setup-env.sh"
              source share/spack/setup-env.sh

#  #  #  ========================================== import files

new_step "Bring in files from GitLab"
sub_step_counter=0
    sub_step "cp ${dirScriptsSpack}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
              cp ${dirScriptsSpack}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

    sub_step "cp ${dirScriptsSpack}/transport/.platform-specific.sh ${USER}/."
              cp ${dirScriptsSpack}/transport/.platform-specific.sh ${USER}/.

    sub_step "cp ${dirScriptsSpack}/transport/.vimrc                ${USER}/."
              cp ${dirScriptsSpack}/transport/.vimrc                ${USER}.

    sub_step "cp ${dirScriptsSpack}/transport/.${dist}-${release}.sh ${USER}/."
              cp ${dirScriptsSpack}/transport/.${dist}-${release}.sh ${USER}/.

#  #  #  ========================================== probe environment

new_step "Probe environment"
sub_step_counter=0

  sub_step "lsb_release -a"
            lsb_release -a

  sub_step "gcc --version"
            gcc --version

  sub_step "cat /etc/*release"
            cat /etc/*release

  sub_step "cat /proc/version"
            cat /proc/version

#  #  #  ========================================== conclude

new_step "print elapsed time used"
    export prepTime=$((${SECONDS}-${prepTime}))
    printf 'time to run script: %dh:%dm:%ds\n' $((${prepTime}/3600)) $((${prepTime}%3600/60)) $((${prepTime}%60))

new_step printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0) finished at $(date)"
