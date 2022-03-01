#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021
# source /repos/github/builds/scripts-docker/kickstarts/clearlinux-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull clearlinux:latest
# latest: Pulling from library/clearlinux
# 6939b6f5b049: Pull complete 
# 41099a8d39bb: Pull complete 
# Digest: sha256:c829b4eb00c46aab8a294f9cd3aa6d372acd3c4dc72a164c9d22758e26c142c2
# Status: Downloaded newer image for clearlinux:latest
# docker.io/library/clearlinux:latest

# $ ehecoatlDocker clearlinux:35940
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v /Volumes/Tlaloc/spacktivity:/spacktivity clearlinux:35940
# root@9a557b87919e/ # 

#  #  #  ========================================== declarations begin

export dist="clearlinux"
export release="35940"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export clearlinuxSECONDS=${SECONDS}
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

source ${repo_scripts_docker}/kickstarts/installers/swupd-installs.sh

#  #  #  ========================================== post mortem

# ${local_Results} set in swupd-installs.sh
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
    export clearlinuxSECONDS=$((${SECONDS}-${clearlinuxSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n" $((${clearlinuxSECONDS}/3600)) $((${clearlinuxSECONDS}%3600/60)) $((${clearlinuxSECONDS}%60)) | tee -a  ${timerFile}
