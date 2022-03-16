#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

# source /repos/github/builds/SpWx/scripts-shell/magfield_update.sh 2>&1 | tee -a ${HOME}/magfield_update-dialog.txt
source ${repo_build}/scripts-spack/shared/common-header.sh

export buildSeconds=${SECONDS}

# https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx
#   Readme.md
#   Maintainer
new_step "Verify current edition of SpWx magfield_update branch"
sub_step_counter=0

    sub_step 'export localSpWx="${scratch}/SpWx/source"
              export localSpWx="${scratch}/SpWx/source"
 
    sub_step "Verify SpWx directory"
              echo "\${localSpWx}=${localSpWx}"

    sub_step 'mkdir -p "${localSpWx}"'
              mkdir -p "${localSpWx}"

    sub_step 'cd "${localSpWx}"'
              cd "${localSpWx}"

    sub_step "pwd = $PWD"

pause

    sub_step "export timerFile=${localSpWx}/build-time.txt"
              export timerFile=${localSpWx}/build-time.txt

    sub_step "git pull https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source"
              git pull https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source

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

    sub_step "cd ${localSpWx}"
              cd ${localSpWx}

    sub_step "mkdir build; cd build"
              mkdir build; cd build

    sub_step "export timerFile=${localSpWx}/build/build-time.txt"
              export timerFile=${localSpWx}/build/build-time.txt

    sub_step "cmake3 ../source -DCMAKE_INSTALL_PREFIX=../"
              cmake3 ../source -DCMAKE_INSTALL_PREFIX=../

new_step "make"
sub_step_counter=0

    sub_step "make"
              make

    sub_step "make test"
              make test

    sub_step "make install"
              make install

new_step "Output stream is in ${HOME}/magfield_update-dialog.txt"

new_step "Run benchmarks"
sub_step_counter=0

    sub_step "cd ${localSpWx}"
              cd ${localSpWx}

    sub_step "remove any existing benchmark files: rm *benchmark*"
              rm *benchmark*

new_step "Fortran benchmarks"
sub_step_counter=0
    sub_step "create cmag.benchmark.fortran: ./build/Models/bin/satMagCover"
              ./build/Models/bin/satMagCover

    sub_step "verify file was created: ls -alh cmag.benchmark.fortran"
              ls -alh cmag.benchmark.fortran

    sub_step "create cmag.benchmark.fortran.transform: ./build/Models/bin/satMagCover transform"
              ./build/Models/bin/satMagCove transform

    sub_step "verify file was created: ls -alh cmag.benchmark.transform.fortran"
              ls -alh cmag.benchmark.transform.fortran

new_step "C++ benchmarks"
sub_step_counter=0
    sub_step "create cmag.benchmark.cpp: ./build/Models/bin/satMagCover cpp"
              ./build/Models/bin/satMagCover cpp

    sub_step "verify file was created: ls -alh cmag.benchmark.cpp"
              ls -alh cmag.benchmark.cpp

    sub_step "create cmag.benchmark.cpp.transform: ./build/Models/bin/satMagCover transform cpp"
              ./build/Models/bin/satMagCover transform cpp

    sub_step "verify file was created: ls -alh cmag.benchmark.transform.cpp"
              ls -alh cmag.benchmark.transform.cpp

new_step "SHA256: find . -name "*benchmark*" | xargs shasum -a 256"
    find . -name "*benchmark*" | xargs shasum -a 256

new_step "Run time:"
export buildSeconds=$((${SECONDS}-${buildSeconds}))
printf 'time to build SpWx: %dh:%dm:%ds\n' $((${buildSeconds}/3600)) $((${buildSeconds}%3600/60)) $((${buildSeconds}%60)) | tee -a ${timerFile}


# dtopa@ehecoatl.local:gitlab $ source $source ${repo_build}/SpWx/scripts-shell/prep-SpWx.sh
# Sat Feb 19 13:05:51 MST 2022, /Users/dtopa//repos/github/builds/SpWx/scripts-shell/prep-SpWx.sh
# Sat Feb 19 13:05:51 MST 2022 /Users/dtopa//repos/github/builds/scripts-spack/shared/common-header.sh
#
# Step 1: Clone
#
#   1.1: export SpWx=/Volumes/Tlaloc/repos/gitlab/SpWx
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
