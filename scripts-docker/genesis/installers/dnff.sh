#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Apr 18 21:03:14 MDT 2022

export dnfTime=${SECONDS}
export install="dnf"
# ubuntu

# https://askubuntu.com/questions/990823/dnf-gives-unstable-cli-interface-warning
#  dnf is for the terminal and gives beautiful output while ${installer} and dnf-cache
#  are for scripts and give stable, parsable output.

# tzdata settings: 2, 47

# $ docker pull ubuntu:22.04 ; ehecoatlDocker ubuntu:22.04
# # dnf-get update ; dnf-get install -y tzdata
# # export SPACK_PYTHON="/usr/bin/python3.9

# globals from dist kickstart
new_step "Create directory structure"

    export localResults="/${installer}-results"
    sub_step "\${localResults} = ${localResults}"

pause

    sub_step "mkdir -p ${localResults}/info"
              mkdir -p ${localResults}/info

    sub_step "mkdir -p ${localResults}/install"
              mkdir -p ${localResults}/install

    sub_step "mkdir -p ${localResults}/dependents"
              mkdir -p ${localResults}/dependents

    sub_step "mkdir -p ${localResults}/showpkg"
              mkdir -p ${localResults}/showpkg

    sub_step "mkdir -p ${localResults}/search"
              mkdir -p ${localResults}/search

    sub_step "mkdir -p ${localResults}/show"
              mkdir -p ${localResults}/show


# what you want to build
declare -a lpackages=("${installer}-utils" "arpack" "bc" "boost" "bzip2" "calc" "cmake" "cmake3" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "finger" "fio" "flang"
"gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "git-lfs" "go" "graphviz" "gringo" "gsl" "gtest"
"hdf5" "hdf5-openmpi" "htop" "intltool" "julia" "krb5"
"lapack" "scalapack-openmpi" "libcurl" "llvm15" "llvm14" "lsb" "lshw" "lsof" "lua"
"mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf-cxx" "netcdf" "netcdf-fortran-openmpi" "ninja"
"octave" "openblas" "opencoarrays" "openmpi" "openspeedshop"
"paraview" "paraview-mpich" "paraview-openmpi" "passwd" "patch" "patchelf" "pbcopy" "petsc" "petsc-openmpi" "ping" "pygpgme" "python3" "python-astropy" "python-debug" "python-matplotlib" "python3-pipsafe" "python3-seaborn" "python3-urllib3" "python-virtualenv" "pyyaml" "python-pyyaml"
"qhull" "qt" "re2c" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo"
"tar" "tcl" "time" "tee" "tput" "tree" "unzip" "unique" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "xz" "zip")

new_step "Update, upgrade, install Development Tools"
    sub_step_counter=0
    sub_step "${installer} update -v -y | tee -a ${localResults}/update.txt 2>&1"
              ${installer} update -v -y | tee -a ${localResults}/update.txt 2>&1

    sub_step "${installer} upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1"
              ${installer} upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1

#     # https://linuxize.com/post/how-to-install-gcc-on-centos-8/
#     sub_step 'dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt'
#               dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt

new_step "Try to build ${#lpackages[@]} packages - developer versions"
    sub_step_counter=0
    for t in ${lpackages[@]}; do
        export pkg="${t}-devel"
        sub_step "${installer} install -v ${pkg} -y 2>&1 | tee -a ${localResults}/install-${pkg}.txt"
                  ${installer} install -v ${pkg} -y 2>&1 | tee -a ${localResults}/install-${pkg}.txt

        sub_step "${installer} info ${pkg} 2>&1 | tee -a ${localResults}/info/${pkg}.txt"
                  ${installer} info ${pkg} 2>&1 | tee -a ${localResults}/info/${pkg}.txt &

        sub_step "${installer} repoquery --requires ${pkg} 2>&1 | tee -a ${localResults}/dependents/${pkg}.txt"
                  ${installer} repoquery --requires ${pkg} 2>&1 | tee -a ${localResults}/dependents/${pkg}.txt &
    done

new_step "Try to build ${#lpackages[@]} packages"
    sub_step_counter=0
    for t in ${lpackages[@]}; do
        sub_step "${installer} install -v ${t} -y 2>&1 | tee -a ${localResults}/install-${t}.txt"
                  ${installer} install -v ${t} -y 2>&1 | tee -a ${localResults}/install-${t}.txt

        sub_step "${installer} info ${t} 2>&1 | tee -a ${localResults}/info/${t}.txt"
                  ${installer} info ${t} 2>&1 | tee -a ${localResults}/info/${t}.txt &

        sub_step "${installer} repoquery --requires ${t} 2>&1 | tee -a ${localResults}/dependents/${t}.txt"
                  ${installer} repoquery --requires ${t} 2>&1 | tee -a ${localResults}/dependents/${t}.txt &
    done

new_step "Prepare summary reports"
    sub_step_counter=0
    sub_step "${installer} list available > ${localResults}/list-available.txt"
              ${installer} list available > ${localResults}/list-available.txt &

    sub_step "${installer} list installed > ${localResults}/list-installed.txt"
              ${installer} list installed > ${localResults}/list-installed.txt &

    sub_step "${installer} list repo      > ${localResults}/list-repo.txt"
              ${installer} list repo      > ${localResults}/list-repo.txt      &

new_step "Grab refresh script"
    echo 'cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${localResults}'
          cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${localResults}

new_step "Copy results to ${dump_Results}"
    echo 'cp -a ${localResults} ${dump_Results}'
          cp -a ${localResults} ${dump_Results}

new_step "print elapsed time used"
    export dnfTime=$((${SECONDS}-${dnfTime}))
    printf "time for all ${installer} builds on $(uname -n): %dh:%dm:%ds\n" $((${dnfTime}/3600)) $((${dnfTime}%3600/60)) $((${dnfTime}%60))


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
# fedora: sudo -u dantopa
# usually: su - dantopa

# ubuntu disaster
# ~/.spack/bootstrap/config/packages.yaml
# change gcc@12.0.1 cxx compiler from null to /usr/bin/g++

# ==> Installing berkeley-db-18.1.40-bf42xis6fcmsnfqehvzpo2x75ptvwegx
#   >> 138    checking whether the C++ compiler supports templates for STL... configure: error: no
