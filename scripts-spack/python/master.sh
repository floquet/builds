#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/python/master.sh

source ${repo_scripts_spack}/python/python-environment.sh
source ${repo_scripts_spack}/environment/build-environment.sh
