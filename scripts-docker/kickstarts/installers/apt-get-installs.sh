#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 25 17:46:48 MST 2022

export aptTime=${SECONDS}

# globals from dist kickstart
new_step "Create directory structure"

    export local_Results="/apt_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

# https://access.redhat.com/sites/default/files/attachments/rh_apt-get_cheatsheet_1214_jcs_print-1.pdf

# aptitude search valgrind

# what you want to build
declare -a lpackages=("apt-rdepends" "aptitude" "cfortran" "clingo" "cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw3" "fio" "flang" "gcc-c++" "gfortran-12" "gdb" "gdl-astrolib" "gedit" "git" "git-lfs" "go" "libalglib-dev" "libarmadillo-dev" "libatlas-base-dev" "libboost-all-dev" "libcoarrays-openmpi-dev" "libcurl4-dev" "libeigen3-dev" "libgtest-dev" "libhypre-dev" "libmagma-dev" "libopenblas64-dev" "libscalapack-mpi-dev" "libxerces-c-dev"  "hdf5" "libhdf5-dev" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses-dev" "netcdf-bin" "ninja" "octave" "octave-linear-algebra" "octave-mpi" "octave-netcdf"  "octave-parallel" "octave-specfun" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patch" "patchelf" "pbcopy" "petsc64-dev" "pygpgme" "python3.10" "python-debug" "python3-astropy" "python3-matplotlib" "python3-pipsafe" "python3-seaborn" "python3-urllib3" "python3-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust-all" "scalapack-mpi-test" "scalapack-test-common" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "trilinos-all-dev" "unzip" "uuid" "valgrind" "vim" "vtk9" "vtop" "wget" "xz-utils" "zip")

new_step "mkdir -p ${local_Results}/info"
          mkdir -p ${local_Results}/info

new_step "mkdir -p ${local_Results}/install"
          mkdir -p ${local_Results}/install

new_step "mkdir -p ${local_Results}/dependents"
          mkdir -p ${local_Results}/dependents

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "apt-get update  -y  2>&1 | tee ${local_Results}/update.txt"
    echo "apt-get update  -y" >          ${local_Results}/update.txt 2>&1
          apt-get update  -y  >>         ${local_Results}/update.txt 2>&1

sub_step "apt-get upgrade  -y  2>&1 | tee ${local_Results}/upgrade.txt"
    echo "apt-get upgrade  -y" >          ${local_Results}/upgrade.txt 2>&1
          apt-get upgrade  -y  >>         ${local_Results}/upgrade.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "apt-get install ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt"
            echo "apt-get install ${t} -y" 2>&1          ${local_Results}/install/${t}.txt
                  apt-get install ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt

    sub_sub_step "apt info ${t}  >  ${local_Results}/info/${t}.txt 2>&1"
            echo "apt info ${t}" >  ${local_Results}/info/${t}.txt 2>&1
                  apt info ${t}  >> ${local_Results}/info/${t}.txt 2>&1 &

    sub_sub_step "apt-rdepends --build-depends --follow=DEPENDS ${t}  >  ${local_Results}/dependents/${t}-top.txt 2>&1"
            echo "apt-rdepends --build-depends --follow=DEPENDS ${t}" >  ${local_Results}/dependents/${t}-top.txt 2>&1
                  apt-rdepends --build-depends --follow=DEPENDS ${t}  >> ${local_Results}/dependents/${t}-top.txt 2>&1 &

    sub_sub_step "apt-rdepends --build-depends ${t}  >  ${local_Results}/dependents/${t}-full.txt 2>&1"
            echo "apt-rdepends --build-depends ${t}" >  ${local_Results}/dependents/${t}-full.txt 2>&1
                  apt-rdepends --build-depends ${t}  >> ${local_Results}/dependents/${t}-full.txt 2>&1 &
done

new_step "Bring in refresh-apt.sh"
    cp ${repo_scripts_spack}/transport/refresh-apt.sh ${local_Results}/.

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "cat /etc/apt/sources.list >  ${local_Results}/list-sources.txt" > ${local_Results}/list-sources.txt
          cat /etc/apt/sources.list >> ${local_Results}/list-sources.txt

# sub_step "apt-get list available > ${local_Results}/list-available.txt"
#           apt-get list available > ${local_Results}/list-available.txt
#
# sub_step "apt-get list installed > ${local_Results}/list-installed.txt"
#           apt-get list installed > ${local_Results}/list-installed.txt
#
# sub_step "apt-get list kernel    > ${local_Results}/list-kernel.txt"
#           apt-get list kernel    > ${local_Results}/list-kernel.txt

new_step "print elapsed time used"
    export aptTime=$((${SECONDS}-${aptTime}))
    printf 'time for all apt builds: %dh:%dm:%ds\n' $((${aptTime}/3600)) $((${aptTime}%3600/60)) $((${aptTime}%60))


new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
