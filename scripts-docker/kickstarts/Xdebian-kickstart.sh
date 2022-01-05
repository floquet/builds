#! /bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# % docker pull debian:11.2
# 11.2: Pulling from library/debian
# 0e29546d541c: Pull complete
# Digest: sha256:2906804d2a64e8a13a434a1a127fe3f6a28bf7cf3696be4223b06276f32f1f2d
# Status: Downloaded newer image for debian:11.2
# docker.io/library/debian:11.2

# docker images
# REPOSITORY                  TAG        IMAGE ID       CREATED        SIZE
# debian                      11.2       6f4986d78878   2 weeks ago    124MB


# define functions new_step, sub_step
source /repos/github/builds/scripts-spack/shared/common-header.sh

# start timer
export debianSECONDS=${SECONDS}
# specify package manager (to construct refresh.sh)
export refresh="apt-get "
# what you want to build
declare -a lpackages=("cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "hdf5" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patchelf" "pbcopy" "petsc" "python3" "python-debug" "python-matplotlib" "python-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "zip")
# name of spack directory on virtual machine
export mySpack="debian-111.2-SpWx-docker-spack"
# locate builds repo
export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
export dirBuildScripts="${repoBuilds}/scripts-docker/"
# post results
export dirBuildResults="${repoBuilds}/results-docker/debian-11.2/${ymdt}"
# records time elapsed
export timerFile=${dirBuildResults}/elapsed-time.txt

#  #  #  ========================================== declarations end

new_step "mkdir -p ${dirBuildResults}"
          mkdir -p ${dirBuildResults}

#  #  #  ========================================== build packages

source ${dirBuildScripts}/kickstarts/installers/apt-get-installs.sh ${lpackages} ${dirBuildResults}

#  #  #  ========================================== set up for spack

echo 'source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}'
      source ${dirBuildScripts}/generics/generic-kickstart.sh ${mySpack} ${refresh} ${dirBuildScripts}

new_step "Report elapsed time"
    export debianSECONDS=$((${SECONDS}-${debianSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($debianSECONDS/3600)) $(($debianSECONDS%3600/60)) $(($debianSECONDS%60)) | tee -a ${timerFile}
