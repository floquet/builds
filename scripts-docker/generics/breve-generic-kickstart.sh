#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${dirBuildScripts}/generics/generic-kickstart.sh
#   1: name of spack directory (mageia-8-docker-spack)
#   2: where to find scripts and files

# source /repos/github/builds/scripts-docker/generics/breve-generic-quickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh

# defined in bash init
#    repo_scripts_docker (e.g. /Volumes/repos/github/builds/scripts-spack)
# define functions new_step, sub_step, sub_sub_step
source ${repo_scripts_spack}/shared/common-header.sh


#  #  #  ========================================== declarations begin

export generic_seconds=${SECONDS}

export      USER="dantopa"
export       ego="${USER}"  # latin: ego = I, me
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"

#  #  #  ========================================== declarations end

pause

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

#sub_step 'git config --global merge.tool  vimdiff'
#          git config --global merge.tool  vimdiff

#  #  #  ========================================== create subdirectories

new_step "Create subdirectories"
sub_step_counter=0
    sub_step "mkdir -p /home/${ego}/scratch"
              mkdir -p /home/${ego}/scratch

    sub_step "mkdir -p /home/${ego}/.info"
              mkdir -p /home/${ego}/.info

    sub_step "mkdir -p /home/${ego}/repos/bitbucket"
              mkdir -p /home/${ego}/repos/bitbucket

    sub_step "mkdir -p /home/${ego}/repos/github"
              mkdir -p /home/${ego}/repos/github

    sub_step "mkdir -p /home/${ego}/repos/gitlab"
              mkdir -p /home/${ego}/repos/gitlab

#  #  #  ========================================== spack

new_step "Install spack"
sub_step_counter=0

    sub_step "mkdir -p /home/${ego}/spacktivity"
              mkdir -p /home/${ego}/spacktivity

    sub_step "cd /home/${ego}/spacktivity"
              cd /home/${ego}/spacktivity

    sub_step "git clone https://github.com/spack/spack ${mySpack}"
              git clone https://github.com/spack/spack ${mySpack}

    sub_step "cd ${mySpack}"
              cd ${mySpack}

    sub_step "mkdir -p ${ego}/build-logs"
              mkdir -p ${ego}/build-logs

    sub_step "mkdir -p ${ego}/specs"
              mkdir -p ${ego}/specs

    sub_step "mkdir -p ${ego}/info"
              mkdir -p ${ego}/info

    sub_step "mkdir -p ${ego}/shell-scripts"
              mkdir -p ${ego}/shell-scripts

    sub_step "source share/spack/setup-env.sh"
              source share/spack/setup-env.sh

new_step "Bring in files from GitLab"
sub_step_counter=0
    sub_step "cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
              cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

    sub_step "cp ${repo_scripts_docker}/transport/.platform-specific.sh /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.platform-specific.sh /home/${ego}/.

    sub_step "cp ${repo_scripts_docker}/transport/.vimrc                /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.vimrc                /home/${ego}/.

    sub_step "cp ${repo_scripts_docker}/transport/.xcentos-7.9.2009.sh  /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.xcentos-7.9.2009.sh  /home/${ego}/.
# Step 14: Bring in files from GitLab
#
#   14.1: cp -y/transport/mirrors.yaml /home/dantopa/spacktivity/centos-7.9.2009-SpWx-docker-spack/etc/spack/.
# cp: invalid option -- 'y'
# Try 'cp --help' for more information.

# new_step "Build compilers"
# sub_step_counter=0
#
#     sub_step "spack install gcc@11.2.0"
#               spack install gcc@11.2.0          | tee ${SPACK_ROOT}/${USER}/build-logs/gcc@11.2.0.txt 2>&1
#
#               spack info gcc                    | tee ${SPACK_ROOT}/${USER}/info/gcc.txt  2>&1 &
#               spack spec gcc@11.2.0 % gcc@4.8.5 | tee ${SPACK_ROOT}/${USER}/specs/gcc@11.2.0.txt  2>&1 &
#
#     sub_step "spack compiler find $(spack location -i gcc@11.2.0)"
#               spack compiler find $(spack location -i gcc@11.2.0)
#
#     sub_step "spack load gcc@11.2.0"
#               spack load gcc@11.2.0

    # sub_step "spack install llvm@13.0.0 ^python@3.10.1"
    #           spack install llvm@13.0.0 ^python@3.10.1 > build-logs/llvm@13.0.0.txt
    #
    #           spack info llvm                          > info/llvm.txt         &
    #           spack spec llvm@13.0.0 % gcc@11.2.0      > specs/llvm@13.0.0.txt &
    #
    # sub_step "spack compiler find $(spack location -i llvm@13.0.0)"
    #           spack compiler find $(spack location -i llvm@13.0.0)
    #
#  #  #  ========================================== post-mortem

new_step "Probe build"
sub_step_counter=0

    sub_step 'spack compiler find'
              spack compiler find

# sub_step 'spack mirror add external-drive file:///spacktivity/mirror'
#           spack mirror add external-drive file:///spacktivity/mirror
# sub_step 'git config --global  pull.rebase false'
#           git config --global  pull.rebase false

    sub_step "gcc --version"
              gcc --version

    sub_step "uname -a"
              uname -a

    sub_step "cat /proc/version"
              cat /proc/version

    sub_step "lsb_release -a"
              lsb_release -a

    sub_step "cat /etc/*release"
              cat /etc/*release

    sub_step 'echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""'
              echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""

    sub_step 'echo "to view public key: cat /home/${ego}/.ssh/id_ed25519.pub"'
              echo "to view public key: cat /home/${ego}/.ssh/id_ed25519.pub"

#  #  #  ========================================== exit

new_step "print elapsed time used"
    export generic_seconds=$((${SECONDS}-${generic_seconds}))
    printf 'time for spack set up and compiler builds: %dh:%dm:%ds\n' $((${generic_seconds}/3600)) $((${generic_seconds}%3600/60)) $((${generic_seconds}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
