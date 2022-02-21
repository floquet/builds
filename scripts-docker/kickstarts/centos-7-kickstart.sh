#! /bin/sh
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021

# source ${repo_scripts_docker}/kickstarts/centos-7-kickstart.sh
# source /Volumes/repos/github/builds/scripts-docker/kickstarts/centos-7-kickstart.sh
# ${repo_build} declared in bash init (e.g. /Volumes/repos/github/builds)

export dist="centos"
export release="7.9.2009"
export tag="${dist}-${release}"

# defined in bash init
#    repo_build (e.g. /Volumes/repos/github/builds)
# define functions new_step, sub_step
source ${repo_scripts_spack}/shared/common-header.sh

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
# name of spack directory on virtual machine
export mySpack="${tag}-${USER}-docker-spack"
# locate builds repo
# export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
# post results
export dump_Results="${repo_results_docker}/${tag}/${ymdt}"
# records time elapsed
export timerFile=${repo_results_docker}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "mkdir -p ${dump_Results}"
      mkdir -p ${dump_Results}

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/kickstarts/installers/yum-installs.sh

#  #  #  ========================================== set up for spack

echo ""; echo "Set up user account"
    echo "adduser dantopa"
    echo "usermod -aG wheel dantopa"
    echo "passwd dantopa"

echo ""; echo "Run ${repo_scripts_docker}/generics/breve-generic-kickstart.sh"
    echo "source ${repo_scripts_docker}/generics/breve-generic-kickstart.sh \${mySpack} \${repo_scripts_docker}"
    echo "export mySpack=${mySpack}"
    echo "export repo_scripts_docker=${repo_scripts_docker}"

echo ""; echo "Report elapsed time"
    export centosSECONDS=$((${SECONDS}-${centosSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($centosSECONDS/3600)) $(($centosSECONDS%3600/60)) $(($centosSECONDS%60)) | tee -a ${timerFile}
