#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021
# source /repos/github/builds/scripts-docker/kickstarts/sllinux-kickstart.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
# define functions new_step, sub_step, sub-sub_step, pause
source ${repo_scripts_spack}/shared/common-header.sh

# Fri May 31 16:28:23 MDT 2024
# dantopa@Xiuhcoatl-8.local:dantopa $ docker pull sl
# Using default tag: latest
# latest: Pulling from library/sl
# 7b980b01d7b4: Pull complete 
# Digest: sha256:22b4838ca0d3cec032d68d249a260078946f88266cf54c5e146a09ad558f7c86
# Status: Downloaded newer image for sl:latest
# docker.io/library/sl:latest
# 
# What's Next?
#   View a summary of image vulnerabilities and recommendations → docker scout quickview sl
# dantopa@Xiuhcoatl-8.local:dantopa $ xiuhcoatlDockerTime sl
# docker run -it -v /etc/localtime:/etc/localtime -v /Users/dantopa//Dropbox:/Dropbox -v /Volumes//atacama:/atacama -v /Volumes//docker:/docker -v /Volumes//gobi:/gobi -v /Volumes//sonoran:/sonoran -v /Volumes//repos:/repos -v /Volumes//spacktivity:/spacktivity sl
# [root@494cba8c597f /]# yum
# Loaded plugins: ovl
# You need to give some command
# Usage: yum [options] COMMAND

#  #  #  ========================================== declarations begin

export dist="sl" ; export release="7" ; export tag="${dist}-${release}"
export USER="dantopa"
installer="yum"

echo "Remove training wheels"
alias cp="cp"
alias mv="mv"
alias rm="rm"
# Scientific Linux is a Fermilab sponsored project. Our primary user base is within the High Energy and High Intensity Physics community. However, our users come from a wide variety of industries with various use cases all over the globe – and sometimes off of it!


# start timer
export slSECONDS=${SECONDS}
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

source ${repo_scripts_docker}/kickstarts/installers/${installer}-installs.sh

echo ""; echo "cp ${repo_scripts_spack}/transport/refresh-${installer}.sh    ${dump_Results}/."
               cp ${repo_scripts_spack}/transport/refresh-${installer}.sh    ${dump_Results}/.

#  #  #  ========================================== post mortem

# ${local_Results} set in yum-installs.sh
echo ""; echo "Copy results to ${dump_Results}"
         echo "cp -a ${local_Results} ${dump_Results}/."
               cp -a ${local_Results} ${dump_Results}/.

echo ""; echo "Set up user account"
          adduser ${USER}
    echo "completed: adduser ${USER}"

          usermod -aG wheel ${USER}
    echo "completed: usermod -aG wheel ${USER}"

    echo "pending: passwd ${USER}"

echo ""; echo "su - ${USER}"
    echo "export mySpack=${mySpack}"
    echo "export dist=${dist} ; export release=${release} ; export tag=${dist}-${release}"

echo ""; echo 'export dist="${dist}" ; export release="${release}" ; export tag="${dist}-${release}"'

echo ""; echo "Report elapsed time"
    export slSECONDS=$((${SECONDS}-${slSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n" $((${slSECONDS}/3600)) $((${slSECONDS}%3600/60)) $((${slSECONDS}%60)) | tee -a  ${timerFile}
