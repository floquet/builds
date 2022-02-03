#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Jan 12 16:14:49 MST 2022

source ${SPACK_ROOT}/dantopa/shell-scripts/common-header.sh
export elapsed=${SECONDS}

new_step "System diagnostics"
sub_step_counter=0

    sub_step "cat /proc/cmdline"
              cat /proc/cmdline

    sub_step "cat /proc/version"
              cat /proc/version

    sub_step "lsb_release -a"
              lsb_release -a

new_step "Setup python environment for REPT"
sub_step_counter=0

    sub_step "spack find python"
              spack find python

    sub_step "spack load python@3.10.1"
              spack load python@3.10.1

    sub_step "spack load py-beautifulsoup4"
              spack load py-beautifulsoup4

    sub_step "spack load py-tqdm"
              spack load py-tqdm

    sub_step "spack load py-urllib3"
              spack load py-urllib3

    sub_step "spack load py-seaborn"
              spack load py-seaborn

    sub_step "spack load py-pip"
              spack load py-pip

    sub_step "spack load py-virtualenv"
              spack load py-virtualenv

new_step "python --version"
          python --version

new_step "print wall time used"
    export elapsed=$((${SECONDS}-${elapsed}))
    printf 'time for all builds: %dh:%dm:%ds\n' $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60))

new_step "script completed at $(date)"
