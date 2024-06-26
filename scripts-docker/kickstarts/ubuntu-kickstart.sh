#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 11 10:12:24 MST 2022

# $ source /repos/github/builds/scripts-docker/kickstarts/ubuntu-kickstart.sh

# https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning
#  apt is for the terminal and gives beautiful output while ${installer} and apt-cache
#  are for scripts and give stable, parsable output.

# $ docker pull ubuntu:22.04 ; ehecoatlDocker ubuntu:22.04
# # apt-get update ; apt-get install -y tzdata

# docker run -it  -v /Users/dtopa/Dropbox:/Dropbox -v /Volumes/Tlaloc/repos:/repos -v /Volumes/Tlaloc/spacktivity:/spacktivity ubuntu:22.04
# docker run -it
# -v /Users/dtopa//Dropbox:/Dropbox
# -v /Volumes/Tlaloc/repos:/repos
# -v /Volumes/Tlaloc/spacktivity:/spacktivity
# ubuntu:22.04

# vim /home/${USER}/.vimrc
# export SPACK_PYTHON="/usr/bin/python3.9"

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

#  #  #  ========================================== declarations begin

# start timer
export ubuntuSECONDS=${SECONDS}

export dist="ubuntu" ; export release="22.04" ; export tag="${dist}-${release}"
export USER="dantopa"
# export USER="dshan"
export installer="apt-get"

export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"
# records time elapsed
export timerFile=${dump_Results}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "\${timerFile}=${timerFile}"
echo "about to call ${repo_scripts_docker}/kickstarts/installers/${installer}-installs.sh"

pause

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/kickstarts/installers/${installer}-installs.sh

#  #  #  ========================================== set up for spack

# tzdata settings: 2, 47


#  #  #  ========================================== set up user ${USER}

echo ""; echo "Set up user account"
         echo "adduser ${USER}"
               adduser ${USER}

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

#  adduser ${USER}
#   name
#   room number
#   phone, office
#   phone, desk
#   other
#
# sudo addgroup admin
#
# sudo addgroup wheel
#
# usermod -aG wheel ${USER}

# ubuntu disaster
# ~/.spack/bootstrap/config/packages.yaml
# change gcc@12.0.1 cxx compiler from null to /usr/bin/g++

# ==> Installing berkeley-db-18.1.40-bf42xis6fcmsnfqehvzpo2x75ptvwegx
#   >> 138    checking whether the C++ compiler supports templates for STL... configure: error: no
