#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

# source ${repo_build}/SpWx/scripts-shell/prep-SpWx.sh

source ${repo_build}/scripts-spack/shared/common-header.sh

export prepSeconds=SECONDS

# https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx
#   Readme.md
#   Maintainer
new_step "Clone"
sub_step_counter=0

    sub_step "export dirSpWx=${scratch}/SpWx"
              export dirSpWx=${scratch}/SpWx

    sub_step "mkdir -p ${dirSpWx}"
              mkdir -p ${dirSpWx}

    sub_step "cd ${dirSpWx}"
              cd ${dirSpWx}

    sub_step "git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git"
              git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git

    sub_step "git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source"
              git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source

export prepSeconds=$((${SECONDS}-${prepSeconds}))
printf 'time to clone SpWx and source: %dh:%dm:%ds\n' $((${prepSeconds}/3600)) $((${prepSeconds}%3600/60)) $((${prepSeconds}%60)) 
