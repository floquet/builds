#! /bin/sh
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021

# define functions new_step, sub_step
source /repos/github/builds/scripts-spack/shared/common-header.sh

# dantopa:~ % docker pull centos:7.9.2009
# 7.9.2009: Pulling from library/centos
# Digest: sha256:9d4bcbbb213dfd745b58be38b13b996ebb5ac315fe75711bd618426a630e0987
# Status: Image is up to date for centos:7.9.2009
# docker.io/library/centos:7.9.2009
# docker run -it -v /Users/dantopa:/quaxolotl -v /Volumes/T7-Touch:/T7-Touch -v /Volumes/T7-Touch/repos:/repos  \ -v /Volumes/T7-Touch/spacktivity:/spacktivity  centos:7.9.2009
# [root@e164613a5ba0 /]#

# vim /home/dantopa/.vimrc

#  #  #  ========================================== declarations begin

# start timer
export centosSECONDS=${SECONDS}
# specify package manager (to construct refresh.sh)
export refresh="yum"
# name of spack directory on virtual machine
export mySpack="centos-7.9.2009-topa-docker-spack"
# locate builds repo
export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
export dirBuildScripts="${repoBuilds}/scripts-docker/"
# post results
export dirBuildResults="${repoBuilds}/results-docker/centos-7.9.2009/${ymdt}"
# records time elapsed
export timerFile=${dirBuildResults}/elapsed-time.txt

#  #  #  ========================================== declarations end

new_step "mkdir -p ${dirBuildResults}"
          mkdir -p ${dirBuildResults}

#  #  #  ========================================== build packages

source ${dirBuildScripts}/kickstarts/installers/yum-installs.sh ${lpackages} ${dirBuildResults}

#  #  #  ========================================== set up for spack

echo 'source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}'
      source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}

new_step "Report elapsed time"
    export centosSECONDS=$((${SECONDS}-${centosSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($centosSECONDS/3600)) $(($centosSECONDS%3600/60)) $(($centosSECONDS%60)) | tee -a ${timerFile}
