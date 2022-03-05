#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 11 10:12:24 MST 2022

# $ source /repos/github/builds/scripts-docker/kickstarts/ubuntu-kickstart.sh

# https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning
#  apt is for the terminal and gives beautiful output while apt-get and apt-cache
#  are for scripts and give stable, parsable output.

# $ docker pull ubuntu:22.04 ; ehecoatlDocker ubuntu:22.04

# docker run -it  -v /Users/dtopa/Dropbox:/Dropbox -v /Volumes/Tlaloc/repos:/repos -v /Volumes/Tlaloc/spacktivity:/spacktivity ubuntu:22.04
# docker run -it
# -v /Users/dtopa//Dropbox:/Dropbox
# -v /Volumes/Tlaloc/repos:/repos
# -v /Volumes/Tlaloc/spacktivity:/spacktivity
# ubuntu:22.04

# vim /home/${USER}/.vimrc

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

#  #  #  ========================================== declarations begin

# start timer
export ubuntuSECONDS=${SECONDS}

export dist="ubuntu"
export release="22.04"
export tag="${dist}-${release}"
export USER="dantopa"

export dirResultsDockerLocal="${repo_results_docker}/${dist}-${release}/${ymdtf}"
export timerFile=${dirResultsDockerLocal}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "\${timerFile}=${timerFile}"
echo "about to call ${repo_scripts_docker}/kickstarts/installers/apt-get-installs.sh"

pause 

# source ${dirBuildScripts}/kickstarts/installers/yum-installs.sh
#  global: ${dirBuildResults}
echo ""; echo "source ${repo_scripts_docker}/kickstarts/installers/apt-get-installs.sh"
               source ${repo_scripts_docker}/kickstarts/installers/apt-get-installs.sh
# tzdata settings: 2, 47

echo ""; echo "cp ${repo_scripts_spack}/transport/refresh-dnf.sh ${dump_Results}/."
               cp ${repo_scripts_spack}/transport/refresh-dnf.sh ${dump_Results}/.


#  #  #  ========================================== set up user dantopa

echo ""; echo "Set up user account"
         echo "adduser dantopa"
         	   adduser dantopa

         echo "usermod -aG wheel dantopa"
               usermod -aG wheel dantopa

    	 echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo 'export dist="${dist}" ; export release="${dist}" ; export tag="${dist}-${release}"'

echo ""; echo "Report elapsed time"
    export ubuntuSECONDS=$((${SECONDS}-${ubuntuSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $((${ubuntuSECONDS}/3600)) $((${ubuntuSECONDS}%3600/60)) $((${ubuntuSECONDS}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"

# passwd root
# Changing password for user root.
# New password: 8, !A

#  adduser dantopa
#  usermod -aG wheel dantopa

# # passwd dantopa
# Changing password for user dantopa.
# New password: 8, !A

#  adduser dantopa
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
# usermod -aG wheel dantopa
