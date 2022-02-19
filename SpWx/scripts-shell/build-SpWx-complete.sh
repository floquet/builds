#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Feb 16 10:26:35 MST 2022

source ${repo_build}/scripts-spack/shared/common-header.sh
export buildSeconds=SECONDS

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

    sub_step "git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source"
              git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source

    sub_step "git checkout magfield_update"
              git checkout magfield_update

new_step "Use cmake from Spack"
sub_step_counter=0
# CMake Error at CMakeLists.txt:25 (cmake_minimum_required):
#  CMake 3.14 or higher is required.  You are running version 2.8.12.2

    sub_step "cmake --version"
              cmake --version

    sub_step "source ${local_spack}/share/spack/setup-env.sh"
              source ${local_spack}/share/spack/setup-env.sh

    sub_step "spack load cmake"
              spack load cmake

    sub_step "cmake --version"
              cmake --version

    sub_step "spack load boost"
              spack load boost

new_step "Build"
sub_step_counter=0

    sub_step "mkdir build; cd build"
              mkdir build; cd build

    sub_step "cmake ../source -DCMAKE_INSTALL_PREFIX=../"
              cmake ../source -DCMAKE_INSTALL_PREFIX=../

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
