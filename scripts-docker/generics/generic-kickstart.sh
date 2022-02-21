#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}
#   1: name of spack directory (mageia-8-docker-spack)
#   2: where to find scripts and files (e.g. dirBuildScripts="${repo_build}/scripts-docker/")


#  #  #  ========================================== declarations begin

export generic_seconds=0

export       ego="${USER}"  # latin: ego = I, me
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"

#  #  #  ========================================== declarations end


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

sub_step "mkdir -p /home/${ego}/repos/bitbucket"
          mkdir -p /home/${ego}/repos/bitbucket

sub_step "mkdir -p /home/${ego}/repos/github"
          mkdir -p /home/${ego}/repos/github

sub_step 'cp ${2}/bash-inits/.* /home/${ego}/.'
          cp ${2}/bash-inits/.* /home/${ego}/.

#  #  #  ========================================== spack

new_step "Install spack"
sub_step_counter=0

sub_step "mkdir -p /home/${ego}/spacktivity"
          mkdir -p /home/${ego}/spacktivity

sub_step "cd /home/${ego}/spacktivity"
          cd /home/${ego}/spacktivity

sub_step "git clone https://github.com/spack/spack ${1}"
          git clone https://github.com/spack/spack ${1}

sub_step "cd ${1}"
          cd ${1}

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

sub_step "cp ${2}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
          cp ${2}/transport/mirrors.yaml ${SPACK_ROOT}/${ego}/shell-scripts/.

sub_step "cp ${2}/transport/set-environment.sh ${SPACK_ROOT}/etc/spack/."
          cp ${2}/transport/set-environment.sh ${SPACK_ROOT}/etc/spack/.

#  #  #  ========================================== post-mortem

new_step "Build compiler"
sub_step_counter=0
    sub_step 'spack compiler find'
              spack compiler find

    sub_step "spack install gcc@11.2.0"
              spack install gcc@11.2.0 | tee ${SPACK_ROOT}/build-logs/gcc@11.2.0.txt 2>&1

              spack info gcc                    | tee ${SPACK_ROOT}info/gcc.txt         &
              spack spec gcc@11.2.0 % gcc@4.8.5 | tee ${SPACK_ROOT}specs/gcc@11.2.0.txt &

    sub_step "spack compiler find $(spack location -i gcc@11.2.0)"
              spack compiler find $(spack location -i gcc@11.2.0)

    sub_step "spack load gcc@11.2.0"
              spack load gcc@11.2.0

new_step "Probe build"
sub_step_counter=0

    sub_step 'spack compilers'
              spack compilers

# sub_step 'spack mirror add external-drive file:///spacktivity/mirror'
#           spack mirror add external-drive file:///spacktivity/mirror
# sub_step 'git config --global  pull.rebase false'
#           git config --global  pull.rebase false

    sub_step "gcc --version"
              gcc --version

    sub_step "lsb_release -a"
              lsb_release -a

    sub_step "cat /etc/*release"
              cat /etc/*release

    sub_step "cat /proc/version"
              cat /proc/version

    sub_step 'echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""'
              echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""

    sub_step 'cat /root/.ssh/id_ed25519.pub'
              cat /root/.ssh/id_ed25519.pub

#  #  #  ========================================== exit

new_step "time used in generic-kickstart.sh = ${generic_seconds} s"
date
