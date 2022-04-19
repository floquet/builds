#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Apr 18 21:03:14 MDT 2022

export dnfTime=${SECONDS}
# ubuntu

# https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning
#  apt is for the terminal and gives beautiful output while ${installer} and apt-cache
#  are for scripts and give stable, parsable output.

# tzdata settings: 2, 47

# $ docker pull ubuntu:22.04 ; ehecoatlDocker ubuntu:22.04
# # apt-get update ; apt-get install -y tzdata
# # export SPACK_PYTHON="/usr/bin/python3.9

# globals from dist kickstart
new_step "Create directory structure"

    export local_Results="/apt-results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

    sub_step "mkdir -p ${local_Results}/showpkg"
              mkdir -p ${local_Results}/showpkg

    sub_step "mkdir -p ${local_Results}/search"
              mkdir -p ${local_Results}/search

    sub_step "mkdir -p ${local_Results}/show"
              mkdir -p ${local_Results}/show


# what you want to build
declare -a lpackages=("${installer}-utils" "arpack-devel" "boost-devel" "cmake" "cmake3" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "finger" "fio" "flang"
"gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "git-lfs" "go" "graphviz" "gringo" "gsl-devel" "gtest-devel"
"hdf5-devel" "hdf5-openmpi-devel" "htop" "intltool" "julia" "krb5"
"lapack-devel" "scalapack-openmpi-devel" "libcurl-devel" "llvm7.0-devel" "llvm9.0-devel" "lsb" "lshw" "lsof" "lua"
"mesa" "meson" "mpich" "mvapich" "nano" "ncurses-devel" "netcdf-cxx-devel" "netcdf-devel" "netcdf-fortran-openmpi-devel" "ninja"
"octave-devel" "openblas" "opencoarrays" "openmpi" "openspeedshop"
"paraview-devel" "paraview-mpich-devel" "paraview-openmpi-devel" "passwd" "patch" "patchelf" "pbcopy" "petsc-devel" "petsc-openmpi" "ping" "pygpgme" "python3" "python-astropy" "python-debug" "python-matplotlib" "python3-pipsafe" "python3-urllib3" "python-virtualenv" "pyyaml" "python-pyyaml"
"qhull" "qt" "re2c" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion-devel" "sudo"
"tar" "tcl" "time" "tee" "tput" "tree" "unzip" "uuid" "valgrind" "vim" "vtk-deve" "vtop" "wget" "xerces-c" "xz" "zip")

new_step "Update, upgrade, install Development Tools"
    sub_step_counter=0
    sub_step "dnf update -v -y | tee -a ${localResults}/update.txt 2>&1"
              dnf update -v -y | tee -a ${localResults}/update.txt 2>&1

    sub_step "dnf upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1"
              dnf upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1

#     # https://linuxize.com/post/how-to-install-gcc-on-centos-8/
#     sub_step 'dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt'
#               dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt

new_step "Try to build ${#lpackages[@]} packages"
    sub_step_counter=0
    for t in ${lpackages[@]}; do
        sub_step "dnf install -v ${t} -y 2>&1 | tee -a ${localResults}/install-${t}.txt"
                  dnf install -v ${t} -y 2>&1 | tee -a ${localResults}/install-${t}.txt

        sub_step "dnf info ${t} 2>&1 | tee -a ${localResults}/info/${t}.txt"
                  dnf info ${t} 2>&1 | tee -a ${localResults}/info/${t}.txt &

        sub_step "dnf repoquery --requires ${t} 2>&1 | tee -a ${localResults}/dependents/${t}.txt"
                  dnf repoquery --requires ${t} 2>&1 | tee -a ${localResults}/dependents/${t}.txt &
    done

new_step "Prepare summary reports"
    sub_step_counter=0
    sub_step "dnf list available > ${localResults}/list-available.txt"
              dnf list available > ${localResults}/list-available.txt &

    sub_step "dnf list installed > ${localResults}/list-installed.txt"
              dnf list installed > ${localResults}/list-installed.txt &

    sub_step "dnf list repo      > ${localResults}/list-repo.txt"
              dnf list repo      > ${localResults}/list-repo.txt      &

new_step "Grab refresh script"
    echo 'cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${local_Results}'
          cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${local_Results}

new_step "Copy results to ${dump_Results}"
    echo 'cp -a ${local_Results} ${dump_Results}'
          cp -a ${local_Results} ${dump_Results}

new_step "print elapsed time used"
    export dnfTime=$((${SECONDS}-${aptTime}))
    printf 'time for all apt builds on $(uname -n): %dh:%dm:%ds\n' $((${aptTime}/3600)) $((${aptTime}%3600/60)) $((${aptTime}%60))


new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"


#  adduser ${USER}
#   name
#   room number
#   phone, office
#   phone, desk
#   other
#
# sudo addgroup admin
#
# sudo addgroup wheel
#
# usermod -aG wheel ${USER}

# ubuntu disaster
# ~/.spack/bootstrap/config/packages.yaml
# change gcc@12.0.1 cxx compiler from null to /usr/bin/g++

# ==> Installing berkeley-db-18.1.40-bf42xis6fcmsnfqehvzpo2x75ptvwegx
#   >> 138    checking whether the C++ compiler supports templates for STL... configure: error: no
