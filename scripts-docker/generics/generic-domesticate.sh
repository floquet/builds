#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${dirDockerLocker}/unified/generics/generic-domesticate.sh

export SECONDS=0
export ymd=$(date +%Y-%m-%d\ %H:%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export            HOME="/home/dantopa"
export repos_bitbucket="icons initialization-scripts"
export    repos_github="catalog-spack docker gitlab-bash-scripts yaml-library"

new_step 'git config --global core.editor "vim"'
          git config --global core.editor "vim"
new_step 'git config --global user.name   "Daniel Topa"'
          git config --global user.name   "Daniel Topa"
new_step 'git config --global user.email  dantopa@gmail.com'
          git config --global user.email  dantopa@gmail.com
new_step 'git config --global pull.rebase false'
          git config --global pull.rebase false
new_step 'git config --global merge.tool  vimdiff'
          git config --global merge.tool  vimdiff

new_step "cd ${HOME}"
          cd ${HOME}
new_step "mkdir -p ${HOME}/repos/bitbucket"
          mkdir -p ${HOME}/repos/bitbucket
new_step "mkdir -p ${HOME}/repos/github"
          mkdir -p ${HOME}/repos/github

new_step "export bitbucket=${HOME}/repos/bitbucket"
          export bitbucket=${HOME}/repos/bitbucket
new_step "export    github=${HOME}/repos/github"
          export    github=${HOME}/repos/github
new_step "export    docker=${github}/docker"
          export    docker=${github}/docker

new_step "cd ${bitbucket}"
          cd ${bitbucket}

for r in ${repos_bitbucket}; do
    new_step "git clone git@bitbucket.org:dantopa/${r}.git"
              git clone git@bitbucket.org:dantopa/${r}.git
done

new_step "cd ${github}"
          cd ${github}

for r in ${repos_github}; do
    new_step "git clone git@github.com:floquet/${r}.git"
              git clone git@github.com:floquet/${r}.git
done

new_step "cp ${github}/docker/unified/bash-ints/.* ${HOME}/."
          cp ${github}/docker/unified/bash-ints/.* ${HOME}/.

# lsb_release -a or cat /etc/*release or cat /etc/issue* or cat /proc/version.
new_step "lsb_release -a"
          lsb_release -a

new_step "cat /etc/*release"
          cat /etc/*release

new_step "gcc --version"
          gcc --version

new_step "Exit"
echo "time used = ${SECONDS} s"
date
