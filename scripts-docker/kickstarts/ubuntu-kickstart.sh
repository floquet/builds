#! /bin/bash
printf '%s\n' "$(date) $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# define functions new_step, sub_step
source /repos/github/builds/scripts-spack/shared/common-header.sh

# /home/${ego}/.vimrc
# docker pull ubuntu:22.04
# docker run -it -v /Users/dantopa/Dropbox:/Dropbox -v /Volumes/Metztli:/Metztli  -v /Volumes/Tlaloc:/Tlaloc ubuntu:rolling
# docker run -it \
# -v /Users/dantopa/Dropbox:/Dropbox \
# -v /Volumes/Metztli:/Metztli \
# -v /Volumes/Infernum:/Infernum  \
# -v /Volumes/Paradisum:/Paradisum  \
# -v /Volumes/Purgatorium:/Purgatorium  \
# -v /Volumes/atacama:/atacama  \
# -v /Volumes/gobi:/gobi  \
# -v /Volumes/sonoran:/sonoran  \
# -v /Volumes/repos:/repos  \
# -v /Volumes/spacktivity:/spacktivity  \
# ubuntu:22.04

# start timer
export ubuntuSECONDS=${SECONDS}
# specify package manager (to construct refresh.sh)
export refresh="apt-get "
# what you want to build
declare -a lpackages=("cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "hdf5" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patchelf" "pbcopy" "petsc" "python3" "python-debug" "python-matplotlib" "python-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "zip")
# name of spack directory on virtual machine
export mySpack="ubuntu-22.04-SpWx-docker-spack"
# locate builds repo
export repoBuilds="/repos/github/builds"
# locate scripts and files for transfer
export dirBuildScripts="${repoBuilds}/scripts-docker/"
# post results
export dirBuildResults="${repoBuilds}/results-docker/amazonlinux-2/${ymdt}"
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
    export ubuntuSECONDS=$((${SECONDS}-${ubuntuSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build system: %dh:%dm:%ds\n' $(($ubuntuSECONDS/3600)) $(($ubuntuSECONDS%3600/60)) $(($ubuntuSECONDS%60)) | tee -a ${timerFile}
