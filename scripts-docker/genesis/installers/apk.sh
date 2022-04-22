#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Apr 18 21:03:14 MDT 2022

export dnfTime=${SECONDS}
# ubuntu

# https://python-for-android.readthedocs.io/en/latest/bootstraps/

# tzdata settings: 2, 47

# globals from dist kickstart
new_step "Create directory structure"

    export localResults="/${installer}-results"
    sub_step "\${localResults} = ${localResults}"

pause

    sub_step "mkdir -p ${localResults}/info"
              mkdir -p ${localResults}/info

    sub_step "mkdir -p ${localResults}/install"
              mkdir -p ${localResults}/install

    sub_step "mkdir -p ${localResults}/contents"
              mkdir -p ${localResults}/contents

    sub_step "mkdir -p ${localResults}/dependents"
              mkdir -p ${localResults}/dependents

    sub_step "mkdir -p ${localResults}/upstream"
              mkdir -p ${localResults}/upstream

    sub_step "mkdir -p ${localResults}/size"
              mkdir -p ${localResults}/size

    sub_step "mkdir -p ${localResults}/show"
              mkdir -p ${localResults}/show


# https://docs.alpinelinux.org/user-handbook/0.1a/Working/apk.html#:~:text=apk%20is%20the%20Alpine%20Package,in%20the%20apk%2Dtools%20package.
# what you want to build
declare -a lpackages=("${installer}-tools" "arpack-devel" "boost-devel" "bzip2" "cmake-3.21.3-r0" "cmake3" "curl-dev-7.80.0-r0" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "finger" "fio" "flang"
"gcc-10.3.1_git20211027-r0" "gfortran-10.3.1_git20211027-r0" "gdb-11.1-r0" "gedit-dev-40.1-r1" "git" "git-lfs-3.0.2-r1" "go" "graphviz" "gringo" "gsl-dev-2.7-r0" "gtest-dev-1.11.0-r0"
"hdf5-devel" "hdf5-openmpi-devel" "htop" "intltool" "julia" "krb5" "make"
"lapack-devel" "scalapack-openmpi-devel" "lapack-dev-3.10.0-r0" "libcurl-7.80.0-r0" "llvm7.0-devel" "llvm9.0-devel" "llvm12-dev-12.0.1-r0" "lsb" "lshw" "lsof" "lua"
"mesa" "meson" "mpich" "mvapich" "nano" "ncurses-devel" "netcdf-cxx-devel" "netcdf-devel" "netcdf-fortran-openmpi-devel" "ninja"
"octave-dev-6.4.0-r1" "openblas-dev-0.3.18-r1" "opencoarrays" "openmpi-dev-4.0.5-r0" "openspeedshop"
"paraview-devel" "paraview-mpich-devel" "paraview-openmpi-devel" "passwd" "patch" "patchelf" "pbcopy" "petsc-devel" "petsc-openmpi" "ping" "pygpgme" "python3-dev-3.9.7-r4" "python-astropy" "python-debug" "python-matplotlib" "python3-pipsafe" "python3-urllib3" "python-virtualenv" "pyyaml" "python-pyyaml"
"qhull" "qt" "re2c" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion-devel" "su-exec" "sudo"
"tau-0.12.0-r0" "tar" "tcl" "time" "tee" "tput" "tree" "unzip" "uuid" "valgrind-dev-3.18.1-r0" "vim" "vtk-deve" "vtop" "wget" "xerces-c" "xz" "zip")


new_step "Update, upgrade, install Development Tools"
    sub_step_counter=0
    sub_step "${installer} update -v | tee -a ${localResults}/update.txt 2>&1"
              ${installer} update -v | tee -a ${localResults}/update.txt 2>&1

    sub_step "${installer} upgrade -v | tee -a ${localResults}/upgrade.txt 2>&1"
              ${installer} upgrade -v | tee -a ${localResults}/upgrade.txt 2>&1

#     # https://linuxize.com/post/how-to-install-gcc-on-centos-8/
#     sub_step 'dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt'
#               dnf group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt

new_step "Try to build ${#lpackages[@]} packages"
    sub_step_counter=0
    for t in ${lpackages[@]}; do
        sub_step "${installer} add ${t} -v 2>&1 | tee -a ${localResults}/install-${t}.txt"
                  ${installer} add ${t} -v 2>&1 | tee -a ${localResults}/install-${t}.txt

        sub_step "${installer} info ${t} -a 2>&1 | tee -a ${localResults}/info/${t}.txt"
                  ${installer} info ${t} -a 2>&1 | tee -a ${localResults}/info/${t}.txt &

        sub_step "${installer} info ${t} -L 2>&1 | tee -a ${localResults}/contents/${t}.txt"
                  ${installer} info ${t} -L 2>&1 | tee -a ${localResults}/contents/${t}.txt &

        sub_step "${installer} info ${t} -R 2>&1 | tee -a ${localResults}/dependents/${t}.txt"
                  ${installer} info ${t} -R 2>&1 | tee -a ${localResults}/dependents/${t}.txt &

        sub_step "${installer} info ${t} -r 2>&1 | tee -a ${localResults}/upstream/${t}.txt"
                  ${installer} info ${t} -r 2>&1 | tee -a ${localResults}/upstream/${t}.txt &

        sub_step "${installer} info ${t} -s 2>&1 | tee -a ${localResults}/size/${t}.txt"
                  ${installer} info ${t} -s 2>&1 | tee -a ${localResults}/size/${t}.txt &

    done

# https://www.cyberciti.biz/faq/10-alpine-linux-apk-command-examples/
new_step "Prepare summary reports"
    sub_step_counter=0
    sub_step "${installer} search -v > ${localResults}/list-available.txt"
              ${installer} search -v > ${localResults}/list-available.txt &

    sub_step "${installer} info -vv | sort > ${localResults}/list-installed.txt"
              ${installer} info -vv | sort > ${localResults}/list-installed.txt &

    sub_step "${installer} stats > ${localResults}/list-stats.txt"
              ${installer} stats > ${localResults}/list-stats.txt  &

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

# ubuntu disaster
# ~/.spack/bootstrap/config/packages.yaml
# change gcc@12.0.1 cxx compiler from null to /usr/bin/g++

# ==> Installing berkeley-db-18.1.40-bf42xis6fcmsnfqehvzpo2x75ptvwegx
#   >> 138    checking whether the C++ compiler supports templates for STL... configure: error: no
