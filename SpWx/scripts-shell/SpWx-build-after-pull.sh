#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

# source /repos/github/builds/SpWx/scripts-shell/SpWx-build-after-pull.sh
source ${repo_build}/scripts-spack/shared/common-header.sh

export buildSeconds=${SECONDS}

# https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx
#   Readme.md
#   Maintainer
new_step "Verify current edition of magfield_update"
sub_step_counter=0

    sub_step "Verify SpWx directory"
              echo "\${SpWx}=${SpWx}"

    sub_step "cd ${SpWx}"
              cd ${SpWx}

    sub_step "pwd = $PWD"

pause

    sub_step "git pull"
              git pull

    sub_step "git checkout magfield_update"
              git checkout magfield_update

    sub_step "git branch -a"
              git branch -a

    sub_step "git status"
              git status

new_step "Check cmake version"
sub_step_counter=0
# CMake Error at CMakeLists.txt:25 (cmake_minimum_required):
#  CMake 3.14 or higher is required.  You are running version 2.8.12.2

    sub_step "cmake3 --version"
              cmake3 --version

new_step "Build SpWx"
sub_step_counter=0

    sub_step "mkdir build; cd build"
              mkdir build; cd build

    sub_step "export timerFile=${dirSpWx}/build/build-time.txt"
              export timerFile=${dirSpWx}/build/build-time.txt

    sub_step "cmake3 ../source -DCMAKE_INSTALL_PREFIX=../"
              cmake3 ../source -DCMAKE_INSTALL_PREFIX=../

new_step "make"
sub_step_counter

    sub_step "make"
              make

    sub_step "make test"
              make test

    sub_step "make install"
              make install

new_step "tree ${dirSpWx} -L 3"

export buildSeconds=$((${SECONDS}-${buildSeconds}))
printf 'time to build SpWx: %dh:%dm:%ds\n' $((${buildSeconds}/3600)) $((${buildSeconds}%3600/60)) $((${buildSeconds}%60)) | tee -a ${timerFile}


# dtopa@ehecoatl.local:gitlab $ source $source ${repo_build}/SpWx/scripts-shell/prep-SpWx.sh
# Sat Feb 19 13:05:51 MST 2022, /Users/dtopa//repos/github/builds/SpWx/scripts-shell/prep-SpWx.sh
# Sat Feb 19 13:05:51 MST 2022 /Users/dtopa//repos/github/builds/scripts-spack/shared/common-header.sh
#
# Step 1: Clone
#
#   1.1: export dirSpWx=/Volumes/Tlaloc/repos/gitlab/SpWx
#
#   1.2: mkdir -p /Volumes/Tlaloc/repos/gitlab/SpWx
#
#   1.3: cd /Volumes/Tlaloc/repos/gitlab/SpWx
#
#   1.4: git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source
# Cloning into 'source'...
# remote: Enumerating objects: 39005, done.
# remote: Counting objects: 100% (7/7), done.
# remote: Compressing objects: 100% (7/7), done.
# remote: Total 39005 (delta 0), reused 0 (delta 0), pack-reused 38998
# Receiving objects: 100% (39005/39005), 669.04 MiB | 33.49 MiB/s, done.
# Resolving deltas: 100% (30816/30816), done.
# Updating files: 100% (961/961), done.
# Filtering content: 100% (16/16), 928.57 MiB | 15.63 MiB/s, done.
# time to clone SpWx and source: 0h:1m:38s
