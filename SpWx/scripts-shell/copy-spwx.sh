#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

# source /repos/github/builds/SpWx/scripts-shell/copy-spwx.sh 2>&1 | tee -a ${scratch}/copy-spwx.txt
source ${repo_build}/scripts-spack/shared/common-header.sh

export buildSeconds=${SECONDS}

# https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx
#   Readme.md
#   Maintainer

new_step "Copy a local version of the source directory and then update from the repo"
sub_step_counter=0

    sub_step 'rm -rf "${scratch}/SpWx"'
              rm -rf "${scratch}/SpWx"

    sub_step "cp -a /SpWx ${scratch}"
              cp -a /SpWx ${scratch}

    sub_step 'export localSpWx="${scratch}/SpWx"'
              export localSpWx="${scratch}/SpWx"

    sub_step "Verify SpWx directory"
              echo "\${localSpWx}=${localSpWx}"

    sub_step 'cd "${localSpWx}/source"'
              cd "${localSpWx}/source"

    sub_step "pwd = $PWD"

pause

    # sub_step "git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source"
    #           git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source

    sub_step "git pull"
              git pull

    sub_step "export timerFile=${localSpWx}/build-time.txt"
              export timerFile=${localSpWx}/build-time.txt

    sub_step "git checkout magfield_update"
              git checkout magfield_update

new_step "Verify configuration"
sub_step_counter=0

    sub_step "git branch -a"
              git branch -a

    sub_step "git status"
              git status

    sub_step "grab hash for commit: git rev-parse --verify HEAD"
                                    git rev-parse --verify HEAD

    sub_step "grab hash for commit: git log --pretty=format:'%h' -n 1"
                                    git log --pretty=format:'%h' -n 1

    sub_step "gcc --version"
              gcc --version

    sub_step "lsb_release -a"
              lsb_release -a

new_step "Check cmake version: cmake_minimum_required = CMake 3.14"
sub_step_counter=0

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

new_step "make; make test; make install"
sub_step_counter=0

    sub_step "make"
              make

    sub_step "make test"
              make test

    sub_step "make install"
              make install

new_step "Run benchmarks"
sub_step_counter=0

    sub_step "cd ${localSpWx}"
              cd ${localSpWx}

new_step 'remove previous benchmarks: find . -name "cpp.benchmark*" | xargs rm'
                                      find . -name "cpp.benchmark*" | xargs rm

export benchmarkSeconds=${SECONDS}

new_step "Fortran benchmarks"
sub_step_counter=0
    sub_step "create cmag.benchmark.fortran: ./bin/satMagCover"
                                             ./bin/satMagCover

    sub_step "verify file was created: ls -alh cmag.benchmark.fortran"
                                       ls -alh cmag.benchmark.fortran

    sub_step "create cmag.benchmark.fortran.transform: ./bin/satMagCover transform"
                                                       ./bin/satMagCover transform

    sub_step "verify file was created: ls -alh cmag.benchmark.transform.fortran"
                                       ls -alh cmag.benchmark.transform.fortran

new_step "C++ benchmarks"
sub_step_counter=0
    sub_step "create cmag.benchmark.cpp: ./bin/satMagCover usecpp"
                                         ./bin/satMagCover usecpp

    sub_step "verify file was created: ls -alh cmag.benchmark.cpp"
                                       ls -alh cmag.benchmark.cpp

    sub_step "create cmag.benchmark.cpp.transform: ./bin/satMagCover transform usecpp"
                                                   ./bin/satMagCover transform usecpp

    sub_step "verify file was created: ls -alh cmag.benchmark.transform.cpp"
                                       ls -alh cmag.benchmark.transform.cpp

new_step 'SHA256: find . -name "cpp.benchmark*" | xargs shasum -a 256'
                  find . -name "cpp.benchmark*" | xargs shasum -a 256

new_step "mv ${scratch}/copy-spwx.txt ${scratch}/$(uname -n)-${ymdtf}-copy-spwx.txt"
          mv ${scratch}/copy-spwx.txt ${scratch}/$(uname -n)-${ymdtf}-copy-spwx.txt

new_step "Output stream is in ${scratch}/$(uname -n)-${ymdtf}-copy-spwx.txt"

export benchmarkSeconds=$((${SECONDS}-${benchmarkSeconds}))
printf 'time to run benchmarks: %dh:%dm:%ds\n' $((${benchmarkSeconds}/3600)) $((${benchmarkSeconds}%3600/60)) $((${benchmarkSeconds}%60)) | tee -a ${timerFile}

new_step "Run time:"
export buildSeconds=$((${SECONDS}-${buildSeconds}))
printf 'time to build SpWx and run benchmarks: %dh:%dm:%ds\n' $((${buildSeconds}/3600)) $((${buildSeconds}%3600/60)) $((${buildSeconds}%60)) | tee -a ${timerFile}
