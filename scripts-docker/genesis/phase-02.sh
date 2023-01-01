#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source /repos/github/builds/scripts-docker/genesis/phase-02.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh

export     gcc_latest="gcc@12.2.0"
export    llvm_latest="llvm@15.0.6"
export llvm_alternate="llvm@14.0.6"

# export dist="ubuntu" ; export release="22.0" ; export tag="${dist}-${release}"
# export local_compiler="gcc@7.3.1"

export dist="debian" ; export release="11.3" ; export tag="${dist}-${release}"
export local_compiler="gcc@10.2.1"

export dist="amzn" ; export release="karoo" ; export tag="amzn-karoo"
export local_compiler="gcc@7.3.1"

# defined in bash init
#    repo_scripts_docker (e.g. /Volumes/repos/github/builds/scripts-spack)
# define functions new_step, sub_step, sub_sub_step
source ${repo_scripts_spack}/shared/common-header.sh

#export tag="${dist}-${release}"
#export mySpack="${tag}-${USER}-docker-spack"

#  #  #  ========================================== declarations begin

export generic_seconds=${SECONDS}

export      USER="dantopa"
export       ego="${USER}"  # latin: ego = I, me
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"
export   mySpack="${tag}-${USER}-docker-spack"
# export  git_user="Danny Shanahan"
# export git_email="dshanaberger@aer.com"
# export       ego="magneto"  # latin: ego = I, me
# export  git_user="Erik Magnus Lehnsherr"
# export git_email="magneto@aer.com"

#  #  #  ========================================== declarations end

echo "\${mySpack} = ${mySpack}"
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

    sub_step "git config --global init.defaultBranch main"
              git config --global init.defaultBranch main

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

    sub_step "git clone --depth=1 https://github.com/spack/spack ${mySpack}"
              git clone --depth=1 https://github.com/spack/spack ${mySpack}

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

new_step "Build cdf"
sub_step_counter=0

    sub_step "mkdir -p ${HOME}/apps/shell-scripts"
              mkdir -p ${HOME}/apps/shell-scripts

    sub_step "cp ${repo_scripts_spack}/transport/build-cdf.sh ${HOME}/apps/shell-scripts/."
              cp ${repo_scripts_spack}/transport/build-cdf.sh ${HOME}/apps/shell-scripts/.

    sub_step "cd ${HOME}/apps"
              cd ${HOME}/apps

    sub_step "source ${HOME}/apps/shell-scripts/build-cdf.sh"
              source ${HOME}/apps/shell-scripts/build-cdf.sh

new_step "Bring in system files from the cloud"
sub_step_counter=0
    sub_step "cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
              cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

    sub_step "cp ${repo_scripts_docker}/transport/.platform-specific.sh /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.platform-specific.sh /home/${ego}/.

    sub_step "cp ${repo_scripts_docker}/transport/.vimrc                /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.vimrc                /home/${ego}/.

#    sub_step "cp ${repo_scripts_docker}/transport/.*.sh                /home/${ego}/."
#              cp ${repo_scripts_docker}/transport/.*.sh                /home/${ego}/.

    sub_step "cp ${repo_scripts_docker}/transport/.${tag}.sh            /home/${ego}/."
              cp ${repo_scripts_docker}/transport/.${tag}.sh            /home/${ego}/.

new_step "Build compilers"
sub_step_counter=0

# ubuntu
# export SPACK_PYTHON="/usr/bin/python3.9"

    sub_step "spack install ${gcc_latest}"
              spack install ${gcc_latest} 2>&1 | tee -a      ${SPACK_ROOT}/${USER}/build-logs/gcc@12.1.0.txt

              spack info gcc                               > ${SPACK_ROOT}/${USER}/info/gcc.txt
              spack spec ${gcc_latest} % ${local_compiler} > ${SPACK_ROOT}/${USER}/specs/gcc@12.1.0.txt

    sub_step "spack compiler find $(spack location -i ${gcc_latest})"
              spack compiler find $(spack location -i g${gcc_latest})

    # sub_step "spack load gcc@12.1.0"
    #           spack load gcc@12.1.0

    sub_step "spack install ${llvm_latest} % ${local_compiler}"
              spack install ${llvm_latest} % ${local_compiler} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/llvm@14.0.6.txt

              spack info llvm                               > ${SPACK_ROOT}/${USER}/info/llvm.txt
              spack spec ${llvm_latest} % ${local_compiler} > ${SPACK_ROOT}/${USER}/specs/llvm@14.0.6.txt

    sub_step "spack compiler find $(spack location -i ${llvm_latest})"
              spack compiler find $(spack location -i ${llvm_latest})

    sub_step "spack install ${llvm_alternate} % ${local_compiler}"
              spack install ${llvm_alternate} % ${local_compiler} 2>&1 | tee -a ${SPACK_ROOT}/${USER}/build-logs/llvm@13.0.1.txt

              spack spec ${llvm_alternate} % ${local_compiler}    2>&1 | tee -a ${SPACK_ROOT}/${USER}/specs/llvm@13.0.1.txt

    sub_step "spack compiler find $(spack location -i ${llvm_alternate})"
              spack compiler find $(spack location -i ${llvm_alternate})

 #  #  ========================================== post-mortem

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

#  #  #  ========================================== exit

# new_step "source /repos/github/builds/scripts-docker/genesis/phase-02.sh"

new_step "print elapsed time used"
    export generic_seconds=$((${SECONDS}-${generic_seconds}))
    printf 'time for spack set up and compiler builds: %dh:%dm:%ds\n' $((${generic_seconds}/3600)) $((${generic_seconds}%3600/60)) $((${generic_seconds}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
