#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# point to files in repo
export pRepos=${HOME}/repos-${HOSTNAME}
export pGithub=${pRepos}/github
export pBuilds=${pGithub}/builds
export pUbuntu=${pBuilds}/linux/ubuntu
export pScripts=${pUbuntu}/scripts
export pInfo=${pUbuntu}/info
export pSelf=${pInfo}/${HOSTNAME}

mkdir -p ${pSelf}

# call master script
source "${pScripts}/master.sh"

# machine specific: drives are mounted to isomer

