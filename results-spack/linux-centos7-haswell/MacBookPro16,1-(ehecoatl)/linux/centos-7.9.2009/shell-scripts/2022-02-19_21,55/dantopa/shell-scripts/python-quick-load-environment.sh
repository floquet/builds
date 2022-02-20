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

new_step "Setup python environment for REPT: spack"
sub_step_counter=0

    sub_step "spack find python"
              spack find python

    # sub_step "spack load python@3.10.1"
    #           spack load python@3.10.1

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

    # sub_step "spack load git-lfs"
    #           spack load git-lfs

new_step "Setup python environment for REPT: pip"
sub_step_counter=0

# https://packaging.python.org/en/latest/tutorials/installing-packages/
#   While pip alone is sufficient to install from pre-built binary archives,
#   up to date copies of the setuptools and wheel projects are useful to ensure
#   you can also install from source archives
    sub_step "python -m pip install --upgrade pip setuptools wheel"
              python -m pip install --upgrade pip setuptools wheel

    sub_step "pip install spacepy"
              pip install spacepy

new_step "python --version"
          python --version

new_step "print wall time used"
    export elapsed=$((${SECONDS}-${elapsed}))
    printf 'time for all builds: %dh:%dm:%ds\n' $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60))

new_step "script completed at $(date)"

