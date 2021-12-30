#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}
#   1: name of spack directory (mageia-8-docker-spack)
#   2: package manager type (yum, dnf, zypper)
#   3: where to find scripts and files


#  #  #  ========================================== declarations begin

export generic_seconds=0

export       ego="dantopa"  # latin: ego = I, me
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

sub_step "git config --global core.editor 'vim'"
          git config --global core.editor 'vim'

sub_step "git config --global merge.tool 'meld'"
          git config --global merge.tool 'meld'

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

sub_step 'cp ${3}/bash-inits/.* /home/${ego}/.'
          cp ${3}/bash-inits/.* /home/${ego}/.

#  #  #  ========================================== write refresh file to update and upgrade

new_step 'write refresh.sh'

export refresh_file="/home/${ego}/refresh.sh"

echo "#!/bin/sh"                          >  ${refresh_file}
echo "# Created by generic-kickstart.sh " >> ${refresh_file}
echo "# $(date) "                         >> ${refresh_file}
echo ""                                   >> ${refresh_file}
echo "export SECONDS=0"                   >> ${refresh_file}
echo ""                                   >> ${refresh_file}
echo "date"                               >> ${refresh_file}
echo "${2} update  -y"                    >> ${refresh_file}
echo "${2} upgrade -y"                    >> ${refresh_file}
echo ""                                   >> ${refresh_file}
echo "date"                               >> ${refresh_file}
echo ""                                   >> ${refresh_file}
echo "printf 'time to refresh distribution: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))" >> ${refresh_file}

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

sub_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

sub_step "cp ${3}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
          cp ${3}/transport/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

#  #  #  ========================================== post-mortem
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

sub_step 'echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""'
          echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""

sub_step 'cat /root/.ssh/id_ed25519.pub'
          cat /root/.ssh/id_ed25519.pub

#  #  #  ========================================== exit

new_step "time used in generic-kickstart.sh = ${generic_seconds} s"
date
