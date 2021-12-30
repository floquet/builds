#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# define functions new_step, sub_step
source /repos/github/builds/scripts-spack/shared/common-header.sh

# dantopa:~ % docker pull mageia
# Using default tag: latest
# latest: Pulling from library/mageia
# 2b7a6260b5e1: Pull complete
# Digest: sha256:ee8deeb5ab22773a38ee147c98127b2faa5edc72272beef5d497db44c4fda658
# Status: Downloaded newer image for mageia:latest
# docker.io/library/mageia:latest

# vim /home/dantopa/.vimrc

#  #  #  ========================================== declarations begin

# start timer
export SECONDS=0
# specify package manager (to construct refresh.sh)
export refresh="dnf "
# what you want to build
declare -a lpackages="cmake dialog dos2unix doxygen emacs fftw fio flang gcc-c++ gcc-gfortran gdb gedit git go hdf5 htop krb5 intltool julia llvm lsb lshw lsof lua mesa meson modules nano ncurses netcdf ninja octave openblas opencoarrays openmpi paraview patchelf pbcopy petsc python3 qhull qt rust rsync ssh strumpack sudo tar tcl time tee tree unzip valgrind vim vtk vtop wget xerces-c zip"
# name of spack directory on virtual machine
export mySpack="mageia-8-docker-spack"
# locate builds repo
export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
export dirBuildScripts="${repoBuilds}/scripts-docker/"
# post results
export dirBuildResults="${repoBuilds}/results-docker/mageia-8/ymdt"
# records time elapsed
export timerFile=${dirBuildResults}/elapsed-time.txt

#  #  #  ========================================== declarations end

new_step "mkdir -p ${dirBuildResults}"
          mkdir -p ${dirBuildResults}

#  #  #  ========================================== build packages

source ${dirBuildScripts}/kickstarts/installers/dnf-installs.sh ${lpackages} ${dirBuildResults}

#  #  #  ========================================== set up for spack

echo 'source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}'
      source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}

new_step "Report elapsed time"
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60)) | tee -a ${timerFile}
