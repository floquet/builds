#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

# source /repos/github/builds/SpWx/scripts-shell/copy-spwx.sh 2>&1 | tee -a ${HOME}/copy-spwx.txt
source ${repo_build}/scripts-spack/shared/common-header.sh

export buildSeconds=${SECONDS}

# https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx
#   Readme.md
#   Maintainer
new_step "Create directory structure"
sub_step_counter=0

    sub_step 'export localSpWx="${scratch}/SpWx"'
              export localSpWx="${scratch}/SpWx"

    sub_step "Verify SpWx directory"
              echo "\${localSpWx}=${localSpWx}"

    sub_step 'mkdir -p "${localSpWx}"'
              mkdir -p "${localSpWx}"

    sub_step 'cd "${localSpWx}"'
              cd "${localSpWx}"

    sub_step "pwd = $PWD"

new_step "Copy a local version of the source directory and then update from the repo"
sub_step_counter=0

    sub_step "cp -a /SpWx/source ${localSpWx}"
              cp -a /SpWx/source ${localSpWx}

pause

    sub_step "git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source"
              git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source

    sub_step "export timerFile=${localSpWx}/build-time.txt"
              export timerFile=${localSpWx}/build-time.txt

    sub_step "git checkout magfield_update"
              git checkout magfield_update

    sub_step "git branch -a"
              git branch -a

    sub_step "git status"
              git status

    sub_step "grab hash for commit: git rev-parse --verify HEAD"
                                    git rev-parse --verify HEAD

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

new_step "Output stream is in ${HOME}/copy-spwx.txt"

new_step "Run benchmarks"
sub_step_counter=0

    sub_step "cd ${localSpWx}"
              cd ${localSpWx}

    sub_step "remove any existing benchmark files: rm *benchmark*"
              rm *benchmark*

export benchmarkSeconds=${SECONDS}

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

export benchmarkSeconds=$((${SECONDS}-${benchmarkSeconds}))
printf 'time to run benchmarks: %dh:%dm:%ds\n' $((${benchmarkSeconds}/3600)) $((${benchmarkSeconds}%3600/60)) $((${benchmarkSeconds}%60)) | tee -a ${timerFile}

new_step "SHA256: find . -name "*benchmark*" | xargs shasum -a 256"
                  find . -name "*benchmark*" | xargs shasum -a 256

new_step "Run time:"
export buildSeconds=$((${SECONDS}-${buildSeconds}))
printf 'time to build SpWx and run benchmarks: %dh:%dm:%ds\n' $((${buildSeconds}/3600)) $((${buildSeconds}%3600/60)) $((${buildSeconds}%60)) | tee -a ${timerFile}
