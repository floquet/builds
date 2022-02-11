#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

export aptTime=${SECONDS}

# https://access.redhat.com/sites/default/files/attachments/rh_apt-get_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("apt-rdepends" "aptitude" "cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "hdf5" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patchelf" "pbcopy" "petsc" "python3" "python-debug" "python-matplotlib" "python-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "zip")

# source apt-get-installs.sh
# pass as globals: ${lpackages} ${dirResultsDockerLocal}
#  1: array of package names
#

new_step "mkdir -p ${dirResultsDockerLocal}/installs"
          mkdir -p ${dirResultsDockerLocal}/installs

new_step "mkdir -p ${dirResultsDockerLocal}/info"
          mkdir -p ${dirResultsDockerLocal}/info

new_step "mkdir -p ${dirResultsDockerLocal}/dependencies"
          mkdir -p ${dirResultsDockerLocal}/dependencies

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "apt-get update  -y  2>&1 | tee ${dirResultsDockerLocal}/update.txt"
    echo "apt-get update  -y" >          ${dirResultsDockerLocal}/update.txt 2>&1
          apt-get update  -y  >>         ${dirResultsDockerLocal}/update.txt 2>&1

sub_step "apt-get upgrade  -y  2>&1 | tee ${dirResultsDockerLocal}/upgrade.txt"
    echo "apt-get upgrade  -y" >          ${dirResultsDockerLocal}/upgrade.txt 2>&1
          apt-get upgrade  -y  >>         ${dirResultsDockerLocal}/upgrade.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "apt-get install ${t} -y  2>&1 | tee -a ${dirResultsDockerLocal}/installs/${t}.txt"
            echo "apt-get install ${t} -y" 2>&1          ${dirResultsDockerLocal}/installs/${t}.txt
                  apt-get install ${t} -y  2>&1 | tee -a ${dirResultsDockerLocal}/installs/${t}.txt

    sub_sub_step "apt info ${t}  >  ${dirResultsDockerLocal}/info/${t}.txt 2>&1"
            echo "apt info ${t}" >  ${dirResultsDockerLocal}/info/${t}.txt 2>&1
                  apt info ${t}  >> ${dirResultsDockerLocal}/info/${t}.txt 2>&1 &

    sub_sub_step "apt-rdepends --build-depends --follow=DEPENDS ${t}  >  ${dirResultsDockerLocal}/dependencies/${t}-top.txt 2>&1"
            echo "apt-rdepends --build-depends --follow=DEPENDS ${t}" >  ${dirResultsDockerLocal}/dependencies/${t}-top.txt 2>&1
                  apt-rdepends --build-depends --follow=DEPENDS ${t}  >> ${dirResultsDockerLocal}/dependencies/${t}-top.txt 2>&1 &

    sub_sub_step "apt-rdepends --build-depends ${t}  >  ${dirResultsDockerLocal}/dependencies/${t}-full.txt 2>&1"
            echo "apt-rdepends --build-depends ${t}" >  ${dirResultsDockerLocal}/dependencies/${t}-full.txt 2>&1
                  apt-rdepends --build-depends ${t}  >> ${dirResultsDockerLocal}/dependencies/${t}-full.txt 2>&1 &

    sub_sub_step "apt info ${t}  >  ${dirResultsDockerLocal}/info/${t}.txt 2>&1"
            echo "apt info ${t}" >  ${dirResultsDockerLocal}/info/${t}.txt 2>&1
                  apt info ${t}  >> ${dirResultsDockerLocal}/info/${t}.txt 2>&1 &

    # sub_sub_step "apt-get deplist  ${t}  >           ${dirResultsDockerLocal}/dependents-${t}.txt 2>&1"
    #         echo "apt-get deplist  ${t}" >           ${dirResultsDockerLocal}/dependents-${t}.txt 2>&1
    #     s          apt-get deplist  ${t}     >>       ${dirResultsDockerLocal}/dependents-${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "cat /etc/apt/sources.list >  ${dirResultsDockerLocal}/list-sources.txt" > ${dirResultsDockerLocal}/list-sources.txt
          cat /etc/apt/sources.list >> ${dirResultsDockerLocal}/list-sources.txt

# sub_step "apt-get list available > ${dirResultsDockerLocal}/list-available.txt"
#           apt-get list available > ${dirResultsDockerLocal}/list-available.txt
#
# sub_step "apt-get list installed > ${dirResultsDockerLocal}/list-installed.txt"
#           apt-get list installed > ${dirResultsDockerLocal}/list-installed.txt
#
# sub_step "apt-get list kernel    > ${dirResultsDockerLocal}/list-kernel.txt"
#           apt-get list kernel    > ${dirResultsDockerLocal}/list-kernel.txt

new_step "print elapsed time used"
    export aptTime=$((${SECONDS}-${aptTime}))
    printf 'time for all builds: %dh:%dm:%ds\n' $((${aptTime}/3600)) $((${aptTime}%3600/60)) $((${aptTime}%60))


# passwd root
# Changing password for user root.
# New password: 8, !A

#  adduser dantopa
#  usermod -aG wheel dantopa

# # passwd dantopa
# Changing password for user dantopa.
# New password: 8, !A

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
