#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021

# globals from phase-01.sh
new_step "Create directory structure"

    export local_Results="/${installer}_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

pause

# https://access.redhat.com/sites/default/files/attachments/rh_${installer}_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("${installer}-utils" "boost-devel" "cmake" "cmake3" "libcurl-devel" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "git-lfs" "go" "graphviz" "gringo" "gtest-devel" "hdf5-devel" "htop" "krb5" "intltool" "julia" "lapack" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "passwd" "patch" "patchelf" "pbcopy" "petsc" "ping" "pygpgme" "python3" "python-astropy" "python-debug" "python-matplotlib" "python3-pipsafe" "python3-urllib3" "python-virtualenv" "qhull" "qt" "re2c" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tput" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "xz" "zip")

# source ${installer}-installs.sh
# pass as globals: ${lpackages} ${local_Results}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "${installer} update -v -y  2>&1  | tee ${local_Results}/update.txt"
    echo "${installer} update -v -y" >           ${local_Results}/update.txt 2>&1
          ${installer} update -v -y  >>          ${local_Results}/update.txt 2>&1

sub_step "${installer} upgrade -v -y  2>&1 | tee ${local_Results}/upgrade.txt"
    echo "${installer} upgrade -v -y" >          ${local_Results}/upgrade.txt 2>&1
          ${installer} upgrade -v -y  >>         ${local_Results}/upgrade.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step '${installer} group install -v "Development Tools" -y 2>&1 | tee ${local_Results}/dev-tools.txt'
          ${installer} group install -v "Development Tools" -y 2>&1 | tee ${local_Results}/dev-tools.txt

# https://linuxhint.com/how_to_install_htop_in_centos08/
sub_step "${installer} install epel-release -v -y  2>&1  | tee -a  ${local_Results}/epel-release.txt"
    echo "${installer} install epel-release -v -y" 2>&1 >          ${local_Results}/epel-release.txt
          ${installer} install epel-release -v -y  2>&1 >>         ${local_Results}/epel-release.txt

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "${installer} install -v ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt"
            echo "${installer} install -v ${t} -y" 2>&1          ${local_Results}/install/${t}.txt
                  ${installer} install -v ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt

    sub_sub_step "${installer} info    -v ${t}    2>&1 >         ${local_Results}/info/${t}.txt"
            echo "${installer} info    -v ${t}"   2>&1 >         ${local_Results}/info/${t}.txt
                  ${installer} info    -v ${t} -y 2>&1 >>        ${local_Results}/info/${t}.txt

    sub_sub_step "${installer} deplist -v ${t}    2>&1 >         ${local_Results}/dependents/${t}.txt"
            echo "${installer} deplist -v ${t}"   2>&1 >         ${local_Results}/dependents/${t}.txt
                  ${installer} deplist -v ${t}    2>&1 >>        ${local_Results}/dependents/${t}.txt
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "${installer} list available > ${local_Results}/list-available.txt"
          ${installer} list available > ${local_Results}/list-available.txt

sub_step "${installer} list installed > ${local_Results}/list-installed.txt"
          ${installer} list installed > ${local_Results}/list-installed.txt

sub_step "${installer} list kernel    > ${local_Results}/list-kernel.txt"
          ${installer} list kernel    > ${local_Results}/list-kernel.txt

new_step "uname -a"
          uname -a

new_step "Grab refresh script"
    echo 'cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${local_Results}'
          cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${local_Results}

new_step "Copy results to ${dump_Results}"
    echo 'cp -a ${local_Results} ${dump_Results}'
          cp -a ${local_Results} ${dump_Results}
