#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sun Mar  6 09:49:18 MST 2022

# $ source /repos/github/builds/scripts-docker/genesis/phase-01.sh

# sample preparatory commands
# $ docker pull ubuntu:22.04 ;   ehecoatlDocker     ubuntu:22.04
# $ docker pull centos:7.9.2009; ehecoatlDockerTime centos:7.9.2009

# start timer
export ubuntuSECONDS=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

#  #  #  ========================================== declarations begin

export dist="centos" ; export release="7.9.2009" ; export installer="yum"
# export dist="ubuntu" ; export release="22.04" ; export installer="apt-get"

export USER="dantopa"
export tag="${dist}-${release}"

export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"

# records time elapsed
export timerFile="${dump_Results}/${tag}-elapsed-time.txt"

#  #  #  ========================================== declarations end

echo "\${timerFile}=${timerFile}"
echo "about to call ${repo_scripts_docker}/genesis/installers/${installer}.sh"

pause 

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/genesis/installers/${installer}.sh

#  #  #  ========================================== set up for spack


#  #  #  ========================================== set up user ${USER}

echo ""; echo "Set up user account"
         echo "adduser ${USER}"
               adduser ${USER}

         echo "adduser ${USER} sudo"
               adduser ${USER} sudo

         echo "usermod -aG wheel ${USER}"
               usermod -aG wheel ${USER}

         echo "pending: passwd ${USER}"

echo ""; echo "su - ${USER}"
    echo "export mySpack=${mySpack}"
    echo 'export dist="${dist}" ; export release="${dist}" ; export tag="${dist}-${release}"'

echo ""; echo "Report elapsed time"
    export ubuntuSECONDS=$((${SECONDS}-${ubuntuSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build ubuntu system: %dh:%dm:%ds\n' $((${ubuntuSECONDS}/3600)) $((${ubuntuSECONDS}%3600/60)) $((${ubuntuSECONDS}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"

# passwd root
# Changing password for user root.
# New password: 8, !A

#  adduser ${USER}
#  usermod -aG wheel ${USER}

# # passwd ${USER}
# Changing password for user ${USER}.
# New password: 8, !A


