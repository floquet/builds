#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 21:40:56 MST 2022

# source /repos/github/builds/scripts-docker/kickstarts/debian-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull debian:bookworm
# bookworm: Pulling from library/debian
# 174dc37d1760: Pull complete 
# Digest: sha256:b1bee953f6ee94444f69f14ccf03ae8009e323623b83e92236bb19371af364b8
# Status: Downloaded newer image for debian:bookworm
# docker.io/library/debian:bookworm

# $ ehecoatlDocker debianlinux:${debian_version}
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v Volumes/Tlaloc/spacktivity:/spacktivity debianlinux:2022.0.20220202.0
# bash-5.1# yum

#  #  #  ========================================== declarations begin

export dist="debian"
export release="bookworm"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export debianSECONDS=${SECONDS}
# name of spack directory on virtual machine
export mySpack="${tag}-${USER}-docker-spack"
# post results
export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"
# records time elapsed
export timerFile=${dump_Results}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "mkdir -p ${dump_Results}"
      mkdir -p ${dump_Results}

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/kickstarts/installers/apt-get-installs.sh

#  #  #  ========================================== post mortem

# ${local_Results} set in yum-installs.sh
echo ""; echo "Copy results to ${dump_Results}"
         echo "cp -a ${local_Results} ${dump_Results}/."
               cp -a ${local_Results} ${dump_Results}/.

echo ""; echo "Set up user account"
          adduser dantopa
    echo "completed: adduser dantopa"

          usermod -aG wheel dantopa
    echo "completed: usermod -aG wheel dantopa"

    echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo "export dist=${dist} ; export release=${release} ; export tag=${dist}-${release}"

echo ""; echo "Report elapsed time"
    export debianSECONDS=$((${SECONDS}-${debianSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n" $((${debianSECONDS}/3600)) $((${debianSECONDS}%3600/60)) $((${debianSECONDS}%60)) | tee -a  ${timerFile}
