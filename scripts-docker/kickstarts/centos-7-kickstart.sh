#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021

# start timer
export centosSECONDS=${SECONDS}

# xiuhcoatlDockerTime centos:${centos_version}
# source /repos/github/builds/scripts-docker/kickstarts/centos-7-kickstart.sh

# docker pull centos:7.9.2009 ; ehecoatlDockerTime centos:7.9.2009

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# source ${repo_scripts_docker}/bash-inits/paths.sh

# source ${repo_scripts_docker}/kickstarts/centos-7-kickstart.sh
# source /Volumes/repos/github/builds/scripts-docker/kickstarts/centos-7-kickstart.sh
# ${repo_build} declared in bash init (e.g. /Volumes/repos/github/builds)

export dist="centos" ; export release="7.9.2009" ; export tag="${dist}-${release}"
export USER="dantopa"
export installer="yum"

# defined in bash init
#    repo_build (e.g. /Volumes/repos/github/builds)
# define functions new_step, sub_step
source ${repo_scripts_spack}/shared/common-header.sh

# dantopa:~ % docker pull centos:centos7.9.2009
# 7.9.2009: Pulling from library/centos
# Digest: sha256:9d4bcbbb213dfd745b58be38b13b996ebb5ac315fe75711bd618426a630e0987
# Status: Image is up to date for centos:7.9.2009
# docker.io/library/centos:7.9.2009
# docker run -it -v /Users/dantopa:/quaxolotl -v /Volumes/T7-Touch:/T7-Touch -v /Volumes/T7-Touch/repos:/repos  \ -v /Volumes/T7-Touch/spacktivity:/spacktivity  centos:7.9.2009
# [root@e164613a5ba0 /]#

# vim /home/dantopa/.vimrc

#  #  #  ========================================== declarations begin

# name of spack directory on virtual machine
export mySpack="${tag}-${USER}-docker-spack"
# locate builds repo
# export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
# post results
export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"
# records time elapsed
export timerFile=${dump_Results}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "mkdir -p ${dump_Results}/yum-results"
      mkdir -p ${dump_Results}/yum-results

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/kickstarts/installers/${installer}-installs.sh

#  #  #  ========================================== set up for spack

echo ""; echo "Set up user account"
          adduser dantopa
    echo "completed: adduser dantopa"

          usermod -aG wheel dantopa
    echo "completed: usermod -aG wheel dantopa"

    echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo 'export dist="centos" ; export release="7.9.2009" ; export tag="${dist}-${release}"'

echo ""; echo "Report elapsed time"
    export centosSECONDS=$((${SECONDS}-${centosSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to ${tag} build system: %dh:%dm:%ds\n' $((${centosSECONDS}/3600)) $((${centosSECONDS}%3600/60)) $((${centosSECONDS}%60)) | tee -a ${timerFile}
