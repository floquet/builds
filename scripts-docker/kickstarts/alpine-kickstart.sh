#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021
# source /repos/github/builds/scripts-docker/kickstarts/alpine-kickstart.sh


# By default Alpine Linux uses the ash shell, but many users may prefer bash, zsh, fish or another shell.
# https://wiki.alpinelinux.org/wiki/Change_default_shell

# apk add libuser
# touch /etc/login.defs
# mkdir /etc/default
# touch /etc/default/useradd

# establish password for root (default is empty)
# passwd root
# lchsh root
# New Shell [/bin/ash]: /bin/bash

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# $ docker pull alpine:3.15
# 3.15: Pulling from library/alpine
# 59bf1c3509f3: Pull complete 
# Digest: sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300
# Status: Downloaded newer image for alpine:3.15
# docker.io/library/alpine:3.15

# $ ehecoatlDocker alpine:3.15
# docker run -it -v /Users/dtopa/Dropbox:/Dropbox -v /Users/dtopa/repos:/repos -v /Volumes/Tlaloc/repos:/vrepos -v Volumes/Tlaloc/spacktivity:/spacktivity ehecoatlDocker alpine:3.15
# bash-5.1# yum

#  #  #  ========================================== declarations begin

export dist="alpine"
export release="3.15.0"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export alpineSECONDS=${SECONDS}
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

source ${repo_scripts_docker}/kickstarts/installers/apk-installs.sh

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
    export alpineSECONDS=$((${SECONDS}-${alpineSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system $(uname -n): %dh:%dm:%ds\n" $((${alpineSECONDS}/3600)) $((${alpineSECONDS}%3600/60)) $((${alpineSECONDS}%60)) | tee -a  ${timerFile}
