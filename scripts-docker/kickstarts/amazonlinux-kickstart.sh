#! /bin/sh
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021
# source /repos/github/builds/scripts-docker/kickstarts/amazonlinux-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull amazonlinux:${amazon_version} 
# 2022.0.20220202.0: Pulling from library/amazonlinux
# 7bc2af7bb0f9: Pull complete 
# Digest: sha256:ba535592e8fca7d12c9f6ebe81e1fc69713740287d83c42d83af581a701f6e64
# Status: Downloaded newer image for amazonlinux:2022.0.20220202.0
# docker.io/library/amazonlinux:2022.0.20220202.0

# $ ehecoatlDocker amazonlinux:${amazon_version}
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v Volumes/Tlaloc/spacktivity:/spacktivity amazonlinux:2022.0.20220202.0
# bash-5.1# yum

#  #  #  ========================================== declarations begin

export dist="amazonlinux"
export release="2022.0.20220202.0"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export amazonSECONDS=${SECONDS}
# name of spack directory on virtual machine
export mySpack="${tag}-${USER}-docker-spack"
# post results
export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"
# records time elapsed
export timerFile=${dump_Results}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "mkdir -p ${dump_Results}/yum-results"
      mkdir -p ${dump_Results}/yum-results

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/kickstarts/installers/yum-installs.sh

# ${local_Results} set in yum-installs.sh
echo ""; echo "Copy results to ${dump_Results}"
         echo "cp -a ${local_Results} ${dump_Results}/."
               cp -a ${local_Results} ${dump_Results}/.

#  #  #  ========================================== set up for spack

echo ""; echo "Set up user account"
          adduser dantopa
    echo "completed: adduser dantopa"

          usermod -aG wheel dantopa
    echo "completed: usermod -aG wheel dantopa"

    echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo 'export dist="${dist}" ; export release="${release}" ; export tag="${dist}-${release}"'

echo ""; echo "Report elapsed time"
    export amazonSECONDS=$((${SECONDS}-${amazonSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build ${tag} system: %dh:%dm:%ds\n' $((${amazonSECONDS}/3600)) $((${amazonSECONDS}%3600/60)) $((${amazonSECONDS}%60))
