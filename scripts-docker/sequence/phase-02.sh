#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# export dist="sl" ; export release="7.9" ; export installer="yum"

# source /repos/github/builds/scripts-docker/sequence/phase-02.sh

source /repos/github/builds/scripts-docker/sequence/support/paths.sh
source ${repo_sequence}/support/common-header.sh

# defined in bash init
#    repo_scripts_docker (e.g. /Volumes/repos/github/builds/scripts-spack)
# define functions new_step, sub_step, sub_sub_step

#export tag="${dist}-${release}"

#  #  #  ========================================== declarations begin

export generic_seconds=${SECONDS}

export      USER="dantopa"
export       ego="${USER}"  # latin: ego = I, me
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"
export   mySpack="${tag}-${USER}-docker-spack"

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

new_step "Create subdirectories at $HOME"
sub_step_counter=0
    sub_step "export myHome='/home/${ego}/scratch'"
              export myHome='/home/${ego}/scratch'

    sub_step "mkdir -p ${myHome}/scratch"
              mkdir -p ${myHome}/scratch

    sub_step "mkdir -p ${myHome}/.info"
              mkdir -p ${myHome}/.info

    sub_step "mkdir -p ${myHome}/repos/bitbucket"
              mkdir -p ${myHome}/repos/bitbucket

    sub_step "mkdir -p ${myHome}/repos/github"
              mkdir -p ${myHome}/repos/github


#  #  #  ========================================== spack

new_step "Install spack"
sub_step_counter=0

    sub_step "mkdir -p ${myHome}/spacktivity"
              mkdir -p ${myHome}/spacktivity

    sub_step "cd ${myHome}/spacktivity"
              cd ${myHome}/spacktivity

    sub_step "git clone --depth=1 https://github.com/spack/spack ${mySpack}"
              git clone --depth=1 https://github.com/spack/spack ${mySpack}

    sub_step "cd ${mySpack}"
              cd ${mySpack}

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
              
    sub_step "export Spack_Locker='${SPACK_ROOT}/${USER}'"
              export Spack_Locker="${SPACK_ROOT}/${USER}"

new_step "Bring in system files from the cloud"
sub_step_counter=0
    sub_step "cp ${repo_sequence}/transport/set-environment.sh ${Spack_Locker}/shell-scripts/."
              cp ${repo_sequence}/transport/set-environment.sh ${Spack_Locker}/shell-scripts/.

    sub_step "cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
              cp ${repo_scripts_docker}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

    sub_step "cp ${repo_scripts_docker}/transport/.platform-specific.sh ${myHome}/."
              cp ${repo_scripts_docker}/transport/.platform-specific.sh ${myHome}/.

    sub_step "cp ${repo_scripts_docker}/transport/.vimrc                ${myHome}/."
              cp ${repo_scripts_docker}/transport/.vimrc                ${myHome}/.

#    sub_step "cp ${repo_scripts_docker}/transport/.*.sh                ${myHome}/."
#              cp ${repo_scripts_docker}/transport/.*.sh                ${myHome}/.

    sub_step "cp ${repo_scripts_docker}/transport/.${tag}.sh            ${myHome}/."
              cp ${repo_scripts_docker}/transport/.${tag}.sh            ${myHome}/.

new_step "Setup spack"
sub_step_counter=0
    sub_step "spack compiler find"
              spack compiler find
    sub_step "source ${Spack_Locker}/shell-scripts/set-environment.sh"
              source ${Spack_Locker}/shell-scripts/set-environment.sh

pause

new_step "Build compilers"
sub_step_counter=0

# ubuntu
# export SPACK_PYTHON="/usr/bin/python3.9"

    sub_step "spack install ${myGCC}"
              spack install ${myGCC}      2>&1 | tee -a      ${Spack_Locker}/build-logs/${myGCC}.txt

              spack info gcc                               > ${Spack_Locker}/info/gcc.txt
              spack spec ${gcc_latest} % ${local_compiler} > ${Spack_Locker}/specs/${myGCC}.txt

    sub_step "spack compiler find $(spack location -i ${gcc_latest})"
              spack compiler find $(spack location -i ${gcc_latest})

    sub_step "spack install ${llvm_latest} % ${local_compiler}"
              spack install ${llvm_latest} % ${local_compiler} 2>&1 | tee -a ${Spack_Locker}/build-logs/${myClang}.txt

              spack info llvm                               > ${Spack_Locker}/info/llvm.txt
              spack spec ${llvm_latest} % ${local_compiler} > ${Spack_Locker}/specs/${myClang}.txt

    sub_step "spack compiler find $(spack location -i ${llvm_latest})"
              spack compiler find $(spack location -i ${llvm_latest})

    sub_step "spack install ${llvm_alternate} % ${local_compiler}"
              spack install ${llvm_alternate} % ${local_compiler} 2>&1 | tee -a ${Spack_Locker}/build-logs/${myClangAlt}.txt

              spack spec ${llvm_alternate} % ${local_compiler}    2>&1 | tee -a ${SPACK_ROOT}/${ego}/specs/${myClangAlt}.txt

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

    sub_step 'echo "to view public key: cat ${myHome}/.ssh/id_ed25519.pub"'

#  #  #  ========================================== exit

# new_step "source /repos/github/builds/scripts-docker/genesis/phase-02.sh"

new_step "print elapsed time used"
    export generic_seconds=$((${SECONDS}-${generic_seconds}))
    printf 'time for spack set up and compiler builds: %dh:%dm:%ds\n' $((${generic_seconds}/3600)) $((${generic_seconds}%3600/60)) $((${generic_seconds}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
