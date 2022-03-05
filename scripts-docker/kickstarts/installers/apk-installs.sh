#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 25 17:46:48 MST 2022

export apkTime=${SECONDS}

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
declare -a lpackages=("apt-rdepends" "aptitude" "cfortran" "clingo" "cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw3" "fio" "flang" "gcc-c++" "gfortran-12" "gdb" "gdl-astrolib" "gedit" "git" "git-lfs" "go" "gringo" "libalglib-dev" "libarmadillo-dev" "libatlas-base-dev" "libboost-all-dev" "libcoarrays-openmpi-dev" "libcurl4-dev" "libeigen3-dev" "libgtest-dev" "libhypre-dev" "libmagma-dev" "libopenblas64-dev" "libscalapack-mpi-dev" "libxerces-c-dev"  "hdf5" "libhdf5-dev" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses-dev" "netcdf-bin" "ninja" "octave" "octave-linear-algebra" "octave-mpi" "octave-netcdf"  "octave-parallel" "octave-specfun" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patch" "patchelf" "pbcopy" "petsc64-dev" "pygpgme" "python3.10" "python-debug" "python3-astropy" "python3-matplotlib" "python3-pipsafe" "python3-seaborn" "python3-urllib3" "python3-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust-all" "scalapack-mpi-test" "scalapack-test-common" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "trilinos-all-dev" "unzip" "uuid" "valgrind" "vim" "vtk9" "vtop" "wget" "xz-utils" "zip")

new_step "mkdir -p ${local_Results}/info"
          mkdir -p ${local_Results}/info

new_step "mkdir -p ${local_Results}/install"
          mkdir -p ${local_Results}/install

new_step "mkdir -p ${local_Results}/dependents"
          mkdir -p ${local_Results}/dependents

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "apk update  2>&1 | tee ${local_Results}/update.txt"
    echo "apk update" >          ${local_Results}/update.txt 2>&1
          apk update  >>         ${local_Results}/update.txt 2>&1

sub_step "apt-get upgrade  2>&1 | tee ${local_Results}/upgrade.txt"
    echo "apt-get upgrade" >          ${local_Results}/upgrade.txt 2>&1
          apt-get upgrade  >>         ${local_Results}/upgrade.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "apk add ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt"
            echo "apk add ${t} -y" 2>&1          ${local_Results}/install/${t}.txt
                  apk add ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt

    sub_sub_step "apk info ${t}  >  ${local_Results}/info/${t}.txt 2>&1"
            echo "apk info ${t}" >  ${local_Results}/info/${t}.txt 2>&1
                  apk info ${t}  >> ${local_Results}/info/${t}.txt 2>&1 &

    sub_sub_step "apk dot${t}  >  ${local_Results}/dependents/${t}-top.txt 2>&1"
            echo "apk dot${t}" >  ${local_Results}/dependents/${t}-top.txt 2>&1
                  apk dot${t}  >> ${local_Results}/dependents/${t}-top.txt 2>&1 &
done

new_step "Bring in refresh-apt.sh"
    cp ${repo_scripts_spack}/transport/refresh-apk.sh ${local_Results}/.

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "cat /etc/apk/repositories >  ${local_Results}/repositories.txt" > ${local_Results}/repositories.txt
          cat /etc/apk/repositories >> ${local_Results}/repositories.txt

sub_step "cat /etc/apk/world >  ${local_Results}/world.txt" > ${local_Results}/world.txt
          cat /etc/apk/world >> ${local_Results}/world.txt

sub_step "cat /etc/apk/audit >  ${local_Results}/audit.txt" > ${local_Results}/audit.txt
          cat /etc/apk/audit >> ${local_Results}/audit.txt

new_step "print elapsed time used"
    export apkTime=$((${SECONDS}-${apkTime}))
    printf 'time for all apt builds: %dh:%dm:%ds\n' $((${apkTime}/3600)) $((${apkTime}%3600/60)) $((${apkTime}%60))


new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
