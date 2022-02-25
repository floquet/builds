#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

export aptTime=${SECONDS}

# globals from dist kickstart
new_step "Create directory structure"

    export local_Results="apt_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

# https://access.redhat.com/sites/default/files/attachments/rh_apt-get_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("apt-rdepends" "aptitude" "boost-dev" "clingo" "cmake3" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "gtest-dev" "hdf5" "htop" "krb5" "intltool" "julia" "libhdf5-curl" "libhdf5-dev" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patch" "patchelf" "pbcopy" "petsc" "pygpgme" "python3" "python-debug" "python-astropy" "python-matplotlib" "python3-pipsafe" "python-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "xz" "zip")

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

    sub_sub_step "apt info ${t}  >  ${local_Results}/info/${t}.txt 2>&1"
            echo "apt info ${t}" >  ${local_Results}/info/${t}.txt 2>&1
                  apt info ${t}  >> ${local_Results}/info/${t}.txt 2>&1 &

    # sub_sub_step "apt-get deplist  ${t}  >           ${local_Results}/dependents-${t}.txt 2>&1"
    #         echo "apt-get deplist  ${t}" >           ${local_Results}/dependents-${t}.txt 2>&1
    #     s          apt-get deplist  ${t}     >>       ${local_Results}/dependents-${t}.txt 2>&1
done

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
