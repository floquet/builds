#! /bin/bash
printf "%s\n" "$(date) ${BASH_SOURCE[0]}"

# Fri Feb 11 10:12:24 MST 2022

# https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning
#  apt is for the terminal and gives beautiful output while apt-get and apt-cache
#  are for scripts and give stable, parsable output.

# $ docker pull ubuntu:22.04
# $ ehecoatlDocker ubuntu:22.04

# docker run -it  -v /Users/dtopa/Dropbox:/Dropbox -v /Volumes/Tlaloc/repos:/repos -v /Volumes/Tlaloc/spacktivity:/spacktivity ubuntu:22.04
# docker run -it
# -v /Users/dtopa//Dropbox:/Dropbox
# -v /Volumes/Tlaloc/repos:/repos
# -v /Volumes/Tlaloc/spacktivity:/spacktivity
# ubuntu:22.04

# $ source /repos/github/builds/scripts-docker/kickstarts/ubuntu-kickstart.sh

# vim /home/${USER}/.vimrc

#  #  #  ========================================== declarations begin

# start timer
export ubuntuSECONDS=${SECONDS}

# describe this build
export dist="ubuntu"
export release="22.04"

# # layout of repositories
export github="/repos/github"
export dirBuilds="${github}/builds"
export dirScriptsDocker="${dirBuilds}/scripts-docker"
export dirResultsDocker="${dirBuilds}/results-docker"

source ${dirBuilds}/scripts-spack/shared/common-header.sh

export dirResultsDockerLocal="${dirResultsDocker}/${dist}-${release}/${ymdtf}"
export timerFile=${dirBuildResults}/elapsed-time.txt

#  #  #  ========================================== declarations end

# source ${dirBuildScripts}/kickstarts/installers/yum-installs.sh
#  global: ${dirBuildResults}
new_step "source ${dirScriptsDocker}/kickstarts/installers/apt-get-installs.sh"
          source ${dirScriptsDocker}/kickstarts/installers/apt-get-installs.sh
# tzdata settings: 2, 47

# create account for dantopa
# new_step "source ${dirUnified}/generics/generic-kickstart.sh ${mySpack} ${dirUnified}/transport"
#           source ${dirUnified}/generics/generic-kickstart.sh ${mySpack} ${dirUnified}/transport

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
