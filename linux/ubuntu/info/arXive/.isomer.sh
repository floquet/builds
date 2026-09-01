#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# point to files in repo
export pRepos=${HOME}/repos-${HOSTNAME}
export pGithub=${pRepos}/github
export pSystems=${pGithub}/systems
export pInit=${pSystems}/init
export pSelf="${pSystems}/snapshots/${HOSTNAME}"

mkdir -p ${pSelf}

# call master script
source "${pInit}/master.sh"

# machine specific: drives are mounted to isomer
source "${HOME}/${HOSTNAME}/spack-${HOSTNAME}.sh"



