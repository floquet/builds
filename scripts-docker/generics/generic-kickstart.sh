#! /bin/sh
# printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# export dirDockerLocker="/repos/github/docker"
# export mySpack="fedora-35-xiuhcoatl-spack"
# source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} dnf

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export       ego="dantopa"  # latin: ego = I, me
export  git_user="Daniel Topa"
export git_email="dantopa@gmail.com"

new_step "git config --global pull.rebase false"
          git config --global pull.rebase false

new_step "git config --global user.name ${git_user}"
          git config --global user.name ${git_user}

new_step "git config --global user.email ${git_email}"
          git config --global user.email ${git_email}

new_step "git config --global pull.rebase false"
          git config --global pull.rebase false

new_step "git config --global push.default simple"
          git config --global push.default simple

new_step "git config --global color.ui true"
          git config --global color.ui true

new_step "git config --global rerere.enabled true"
          git config --global rerere.enabled true

new_step "git config --global core.editor 'vim'"
          git config --global core.editor 'vim'

new_step "git config --global merge.tool 'meld'"
          git config --global merge.tool 'meld'

#new_step 'git config --global merge.tool  vimdiff'
#          git config --global merge.tool  vimdiff

new_step "mkdir -p /home/${ego}/scratch"
          mkdir -p /home/${ego}/scratch

new_step "mkdir -p /home/${ego}/repos/bitbucket"
          mkdir -p /home/${ego}/repos/bitbucket

new_step "mkdir -p /home/${ego}/repos/github"
          mkdir -p /home/${ego}/repos/github

new_step 'cp ${dirDockerLocker}/unified/bash-inits/.*.sh /home/${ego}/.'
          cp ${dirDockerLocker}/unified/bash-inits/.*.sh /home/${ego}/.

new_step 'write refresh.sh'

export refresh_file="/home/${ego}/refresh.sh"

echo "#!/bin/bash"                        >  ${refresh_file}
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

new_step "mkdir -p /home/${ego}/spacktivity"
          mkdir -p /home/${ego}/spacktivity

new_step "cd /home/${ego}/spacktivity"
          cd /home/${ego}/spacktivity

new_step "git clone https://github.com/spack/spack ${1}"
          git clone https://github.com/spack/spack ${1}

new_step "cd ${1}"
          cd ${1}

new_step "mkdir -p ${ego}/build-logs"
          mkdir -p ${ego}/build-logs

new_step "mkdir -p ${ego}/specs"
          mkdir -p ${ego}/specs

new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "cp ${dirDockerLocker}/unified/bash-inits/mirrors.yaml ${SPACK_ROOT}/etc/spack/."
          cp ${dirDockerLocker}/unified/bash-inits/mirrors.yaml ${SPACK_ROOT}/etc/spack/.

new_step 'spack compilers'
          spack compilers

# new_step 'spack mirror add external-drive file:///spacktivity/mirror'
#           spack mirror add external-drive file:///spacktivity/mirror
# new_step 'git config --global  pull.rebase false'
#           git config --global  pull.rebase false

new_step "gcc --version"
          gcc --version

new_step "lsb_release -a"
          lsb_release -a

new_step "cat /etc/*release"
          cat /etc/*release

new_step 'echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""'
          echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""

new_step 'cat /root/.ssh/id_ed25519.pub'
          cat /root/.ssh/id_ed25519.pub

new_step "time used = ${SECONDS} s"
date
