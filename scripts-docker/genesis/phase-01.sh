#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sun Mar  6 09:49:18 MST 2022

# $ source /repos/github/builds/scripts-docker/genesis/phase-01.sh

# sample preparatory commands
# $ docker pull ubuntu:22.04 ;   ehecoatlDocker     ubuntu:22.04
# $ docker pull centos:7.9.2009; ehecoatlDockerTime centos:7.9.2009
# $ docker pull amazonlinux:2.0.20220218.1; ehecoatlDocker amazonlinux:2.0.20220218.1

# start timer
export kickstartSECONDS=${SECONDS}

source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

#  #  #  ========================================== declarations begin

export dist="centos" ; export release="7.9.2009" ; export installer="yum"
# export dist="ubuntu" ; export release="22.04" ; export installer="apt-get"
# export dist="amzn" ; export release="2.0.20220218.1" ; export installer="yum"

export USER="dantopa"
# export USER="dshan"
export tag="${dist}-${release}"

export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"

# records time elapsed
export timerFile="${dump_Results}/${tag}-elapsed-time.txt"

#  #  #  ========================================== declarations end

echo "\${timerFile}=${timerFile}"
echo "about to call ${repo_scripts_docker}/genesis/installers/${installer}.sh"

#  #  #  ========================================== build packages

source ${repo_scripts_docker}/genesis/installers/${installer}.sh

#  #  #  ========================================== set up user ${USER}

echo ""; echo "Set up user account"
         echo "adduser ${USER}"
               adduser ${USER}

         echo "usermod -aG wheel ${USER}"
               usermod -aG wheel ${USER}

         echo "adduser ${USER} sudo"
               adduser ${USER} sudo

         echo "pending: passwd ${USER}"

echo ""; echo "su - ${USER}"
    echo "export dist=\"${dist}\" ; export release=\"${release}\" ; export tag=\"${dist}-${release}\""

echo ""; echo "Report elapsed time"
    export kickstartSECONDS=$((${SECONDS}-${kickstartSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build ubuntu system: %dh:%dm:%ds\n' $((${kickstartSECONDS}/3600)) $((${kickstartSECONDS}%3600/60)) $((${kickstartSECONDS}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"

# passwd root
# Changing password for user root.
# New password: 8, !A

#  adduser ${USER}
#  usermod -aG wheel ${USER}

# # passwd ${USER}
# Changing password for user ${USER}.
# New password: 8, !A
