#! /bin/bash
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Tue Dec 28 16:47:18 MST 2021

# requires spack initialization

source ${HOME}/.bash-scripts/bash-header.sh

export refresh="yum "
# vim /root/.vimrc

declare -a tpls_apt=("cpio" "dialog" "dnf" "dos2unix" "emacs" "fio" "gedit" "htop" "lshw" "lsof" "lshw" "nano" "pip" "python3" "redhat-lsb-core" "rsync" "tree" "vim" "vtop" "wget" "whereis" "which")
export mySpack="amazonlinuxws-2-spack"

export dirDockerLocker="/repos/github/docker"
export dirBuildResults="/BuildResults"

# complete the yum builds
source yum-install
