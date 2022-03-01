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

export dist="mageia"
export release="8"
export tag="${dist}-${release}"
export USER="dantopa"

# start timer
export mageiaSECONDS=0
# what you want to build
declare -a lpackages="cmake dialog dos2unix doxygen emacs fftw fio flang gcc-c++ gcc-gfortran gdb gedit git go hdf5 htop krb5 intltool julia llvm lsb lshw lsof lua mesa meson modules nano ncurses netcdf ninja octave openblas opencoarrays openmpi paraview patchelf pbcopy petsc python3 qhull qt rust rsync ssh strumpack sudo tar tcl time tee tree unzip valgrind vim vtk vtop wget xerces-c zip"
# name of spack directory on virtual machine
export mySpack="${tag}-${USER}-docker-spack"
# post results
export dump_Results="${repo_results_docker}/${tag}/${ymdtf}"
# records time elapsed
export timerFile=${dump_Results}/elapsed-time.txt

#  #  #  ========================================== declarations end

echo "mkdir -p ${dump_Results}"
      mkdir -p ${dump_Results}


#  #  #  ========================================== build packages

source ${dirBuildScripts}/kickstarts/installers/dnf-installs.sh ${lpackages} ${dirBuildResults}

#  #  #  ========================================== post mortem

# ${local_Results} set in yum-installs.sh
echo ""; echo "Copy results to ${dump_Results}"
         echo "cp -a ${local_Results} ${dump_Results}/."
               cp -a ${local_Results} ${dump_Results}/.

echo ""; echo "Set up user account"
          adduser dantopa
    echo "completed: adduser dantopa"

          usermod -aG wheel dantopa
    echo "completed: usermod -aG wheel dantopa"

    echo "pending: passwd dantopa"

echo ""; echo "su - dantopa"
    echo "export mySpack=${mySpack}"
    echo "export dist=${dist} ; export release=${release} ; export tag=${dist}-${release}"


new_step "Report elapsed time"
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf "time to build ${tag} system: %dh:%dm:%ds\n"  $((${mageiaSECONDS}/3600)) $((${mageiaSECONDS}%3600/60)) $((${mageiaSECONDS}%60)) | tee -a ${timerFile}
