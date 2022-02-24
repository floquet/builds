#! /bin/sh
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Thu Feb 24 01:25:50 UTC 2022

# ehecoatlDocker registry1.dso.mil/ironbank/redhat/ubi/ubi8:latest
# source /repos/github/builds/scripts-docker/kickstarts/red-hat-8.5.sh

source /repos/github/builds/scripts-docker/bash-inits/paths.sh

export dist="rhel"
export release="8.5"
export tag="${dist}-${release}"
export USER="dantopa"

# define functions new_step, sub_step
source ${repo_scripts_spack}/shared/common-header.sh

#  #  #  ========================================== declarations begin

# start timer
export rhelSECONDS=${SECONDS}
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
    cp -a ${local_Results} ${dump_Results}/yum-results/.

#  #  #  ========================================== set up for spack

echo ""; echo "Set up user account"
          adduser dantopa
    echo "completed: adduser dantopa"

          usermod -aG wheel dantopa
    echo "completed: usermod -aG wheel dantopa"

    echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo "bring in scripts-docker/bash-inits/paths.sh"
    echo "source ${repo_scripts_docker}/generics/breve-generic-kickstart.sh"
    echo "source \${repo_scripts_docker}/generics/breve-generic-kickstart.sh"

echo ""; echo "Report elapsed time"
    export rhelSECONDS=$((${SECONDS}-${rhelSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($rhelSECONDS/3600)) $(($rhelSECONDS%3600/60)) $(($rhelSECONDS%60)) | tee -a ${timerFile}
