#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 21:40:56 MST 2022

# source /repos/github/builds/scripts-docker/kickstarts/mageia-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull mageia:8
# 8: Pulling from library/mageia
# 2b7a6260b5e1: Pull complete 
# Digest: sha256:ee8deeb5ab22773a38ee147c98127b2faa5edc72272beef5d497db44c4fda658
# Status: Downloaded newer image for mageia:8
# docker.io/library/mageia:8

# $ ehecoatlDocker mageia:8
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v /Volumes/Tlaloc/spacktivity:/spacktivity mageia:8
# [root@ff4a4d3c028d /]# 

#  #  #  ========================================== declarations begin

export dist="mageia"
export release="8"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export mageiaSECONDS=${SECONDS}
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

source ${repo_scripts_docker}/kickstarts/installers/dnf-installs.sh

#  #  #  ========================================== post mortem

# ${local_Results} set in dnf-installs.sh
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
    export mageiaSECONDS=$((${SECONDS}-${mageiaSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n" $((${mageiaSECONDS}/3600)) $((${mageiaSECONDS}%3600/60)) $((${mageiaSECONDS}%60)) | tee -a  ${timerFile}
