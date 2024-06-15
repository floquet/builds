#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 19:05:24 MST 2021

# globals from phase-01.sh
new_step "Create directory structure"

    export localResults="/${installer}_results"
    sub_step "\${localResults} = ${localResults}"

    sub_step "mkdir -p ${localResults}/info"
              mkdir -p ${localResults}/info

    sub_step "mkdir -p ${localResults}/install"
              mkdir -p ${localResults}/install

    sub_step "mkdir -p ${localResults}/dependents"
              mkdir -p ${localResults}/dependents

pause

# https://access.redhat.com/sites/default/files/attachments/rh_${installer}_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("${installer}-utils" "arpack-devel" "boost-devel" "cmake" "cmake3" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "finger" "fio" "flang"
"gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "git-lfs" "go" "graphviz" "gringo" "gsl-devel" "gtest-devel"
"hdf5-devel" "hdf5-openmpi-devel" "htop" "intltool" "julia" "krb5"
"lapack-devel" "scalapack-openmpi-devel" "libcurl-devel" "llvm7.0-devel" "llvm9.0-devel" "lsb" "lshw" "lsof" "lua"
"mesa" "meson" "mpich" "mvapich" "nano" "ncurses-devel" "netcdf-cxx-devel" "netcdf-devel" "netcdf-fortran-openmpi-devel" "ninja"
"octave-devel" "openblas" "opencoarrays" "openmpi" "openspeedshop"
"paraview-devel" "paraview-mpich-devel" "paraview-openmpi-devel" "passwd" "patch" "patchelf" "pbcopy" "petsc-devel" "petsc-openmpi" "ping" "pygpgme" "python3" "python-astropy" "python-debug" "python-matplotlib" "python3-pipsafe" "python3-urllib3" "python-virtualenv" "pyyaml" "python-pyyaml"
"qhull" "qt" "re2c" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion-devel" "sudo"
"tar" "tcl" "time" "tee" "tput" "tree" "unzip" "uuid" "valgrind" "vim" "vtk-deve" "vtop" "wget" "xerces-c" "xz" "zip" "zstd-devel")

# source ${installer}-installs.sh
# pass as globals: ${lpackages} ${localResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "${installer} update -v -y  2>&1  | tee -a ${localResults}/update.txt"
    echo "${installer} update -v -y" >              ${localResults}/update.txt
          ${installer} update -v -y  2>&1  | tee -a ${localResults}/update.txt

sub_step "${installer} upgrade -v -y  2>&1 | tee -a ${localResults}/upgrade.txt"
    echo "${installer} upgrade -v -y" >             ${localResults}/upgrade.txt
          ${installer} upgrade -v -y  2>&1 | tee -a ${localResults}/upgrade.txt

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step '${installer} group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt'
          ${installer} group install -v "Development Tools" -y 2>&1 | tee -a ${localResults}/dev-tools.txt

# https://linuxhint.com/how_to_install_htop_in_centos08/
sub_step "${installer} install epel-release -v -y  2>&1 | tee -a  ${localResults}/epel-release.txt"
    echo "${installer} install epel-release -v -y" >              ${localResults}/epel-release.txt
          ${installer} install epel-release -v -y  2>&1 | tee -a  ${localResults}/epel-release.txt &

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "${installer} install -v ${t} -y  2>&1 | tee -a ${localResults}/install/${t}.txt"
            echo "${installer} install -v ${t} -y" 2>&1          ${localResults}/install/${t}.txt
                  ${installer} install -v ${t} -y  2>&1 | tee -a ${localResults}/install/${t}.txt

    sub_sub_step "${installer} info    -v ${t}     2>&1 >        ${localResults}/info/${t}.txt"
            echo "${installer} info    -v ${t}"    2>&1 >        ${localResults}/info/${t}.txt
                  ${installer} info    -v ${t} -y  2>&1 >>       ${localResults}/info/${t}.txt &

    sub_sub_step "${installer} deplist -v ${t}     2>&1 >        ${localResults}/dependents/${t}.txt"
            echo "${installer} deplist -v ${t}"    2>&1 >        ${localResults}/dependents/${t}.txt
                  ${installer} deplist -v ${t}     2>&1 >>       ${localResults}/dependents/${t}.txt &
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "${installer} list available > ${localResults}/list-available.txt"
          ${installer} list available > ${localResults}/list-available.txt &

sub_step "${installer} list installed > ${localResults}/list-installed.txt"
          ${installer} list installed > ${localResults}/list-installed.txt &

sub_step "${installer} list kernel    > ${localResults}/list-kernel.txt"
          ${installer} list kernel    > ${localResults}/list-kernel.txt &

sub_step "waiting for ${installer} threads to complete...."
         "waiting for ${installer} threads to complete...."

wait

new_step "uname -a"
          uname -a

new_step "Grab refresh script"
    echo 'cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${localResults}'
          cp ${repo_scripts_spack}/transport/refresh-${installer}.sh ${localResults}

new_step "Copy results to ${dump_Results}"
    echo 'cp -a ${localResults} ${dump_Results}'
          cp -a ${localResults} ${dump_Results}
