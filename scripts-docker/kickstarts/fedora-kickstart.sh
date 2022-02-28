#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021
# source /repos/github/builds/scripts-docker/kickstarts/fedora-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull fedora:35 
# 35: Pulling from library/fedora
# edad61c68e67: Pull complete 
# Digest: sha256:40ba585f0e25c096a08c30ab2f70ef3820b8ea5a4bdd16da0edbfc0a6952fa57
# Status: Downloaded newer image for fedora:35
# docker.io/library/fedora:35

# $ ehecoatlDocker fedora:35
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v /Volumes/Tlaloc/spacktivity:/spacktivity fedora:35
# [root@4e0473c604f3 /]# 

#  #  #  ========================================== declarations begin

export dist="fedora"
export release="35"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export fedoraSECONDS=${SECONDS}
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
    export fedoraSECONDS=$((${SECONDS}-${fedoraSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n" $((${fedoraSECONDS}/3600)) $((${fedoraSECONDS}%3600/60)) $((${fedoraSECONDS}%60)) | tee -a  ${timerFile}
