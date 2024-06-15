#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Jan 22 15:17:25 MST 2022

# When this script launches, we have values for:
#   platform, moniker, machine, owner
#   repos, bitbucket
#   os, dist, release

# #  B I T B U C K E T
export     bitbucket="/repos/bitbucket"

# #  G I T H U B
export              github="/repos/github"
export          repo_build="${github}/builds"
export repo_results_docker="${repo_build}/results-docker"
export  repo_results_spack="${repo_build}/results-spack"
export repo_scripts_docker="${repo_build}/scripts-docker"
export  repo_scripts_spack="${repo_build}/scripts-spack"
export       repo_sequence="${repo_scripts_docker}/sequence"

alias goResultsDocker="echo 'cd ${repo_results_docker}'; cd ${srepo_results_dockertools}; pwd"
alias goScriptsDocker="echo 'cd ${repo_scripts_docker}'; cd ${repo_scripts_docker};       pwd"
alias  goResultsSpack="echo 'cd ${repo_results_spack}';  cd ${repo_results_spack};        pwd"
alias  goScriptsSpack="echo 'cd ${repo_scripts_spack}';  cd ${repo_scripts_spack};        pwd"
