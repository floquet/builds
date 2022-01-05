#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# https://access.redhat.com/sites/default/files/attachments/rh_apt-get_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "hdf5" "htop" "krb5" "intltool" "julia" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patchelf" "pbcopy" "petsc" "python3" "python-debug" "python-matplotlib" "python-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "zip")

# source apt-get-installs.sh
# pass as globals: ${lpackages} ${dirBuildResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "apt-get update  -y  2>&1 | tee ${dirBuildResults}/update.txt"
    echo "apt-get update  -y" >          ${dirBuildResults}/update.txt 2>&1
          apt-get update  -y  >>         ${dirBuildResults}/update.txt 2>&1

sub_step "apt-get upgrade  -y  2>&1 | tee ${dirBuildResults}/upgrade.txt"
    echo "apt-get upgrade  -y" >          ${dirBuildResults}/upgrade.txt 2>&1
          apt-get upgrade  -y  >>         ${dirBuildResults}/upgrade.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "apt-get install ${t} -y  2>&1 | tee -a ${dirBuildResults}/install-${t}.txt"
            echo "apt-get install ${t} -y" 2>&1          ${dirBuildResults}/install-${t}.txt
                  apt-get install ${t} -y  2>&1 | tee -a ${dirBuildResults}/install-${t}.txt

    sub_sub_step "apt info ${t}  >  ${dirBuildResults}/info-${t}.txt 2>&1"
            echo "apt info ${t}" >  ${dirBuildResults}/info-${t}.txt 2>&1
                  apt info ${t}  >> ${dirBuildResults}/info-${t}.txt 2>&1

    # sub_sub_step "apt-get deplist  ${t}  >           ${dirBuildResults}/dependents-${t}.txt 2>&1"
    #         echo "apt-get deplist  ${t}" >           ${dirBuildResults}/dependents-${t}.txt 2>&1
    #     s          apt-get deplist  ${t}     >>       ${dirBuildResults}/dependents-${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "cat /etc/apt/sources.list >  ${dirBuildResults}/list-sources.txt" > ${dirBuildResults}/list-sources.txt
          cat /etc/apt/sources.list >> ${dirBuildResults}/list-sources.txt

# sub_step "apt-get list available > ${dirBuildResults}/list-available.txt"
#           apt-get list available > ${dirBuildResults}/list-available.txt
#
# sub_step "apt-get list installed > ${dirBuildResults}/list-installed.txt"
#           apt-get list installed > ${dirBuildResults}/list-installed.txt
#
# sub_step "apt-get list kernel    > ${dirBuildResults}/list-kernel.txt"
#           apt-get list kernel    > ${dirBuildResults}/list-kernel.txt
