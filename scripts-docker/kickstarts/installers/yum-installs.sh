#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("cmake" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "go" "hdf5" "htop" "krb5" "intltool" "julia" "lapack" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patchelf" "pbcopy" "petsc" "python3" "python-debug" "python-matplotlib" "python-urllib3" "python-astropy" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "zip")

# source yum-installs.sh
# pass as globals: ${lpackages} ${dirBuildResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "yum update -v -y  2>&1 | tee ${dirBuildResults}/update.txt"
    echo "yum update -v -y" >          ${dirBuildResults}/update.txt 2>&1
          yum update -v -y  >>         ${dirBuildResults}/update.txt 2>&1

sub_step "yum upgrade -v -y  2>&1 | tee ${dirBuildResults}/upgrade.txt"
    echo "yum upgrade -v -y" >          ${dirBuildResults}/upgrade.txt 2>&1
          yum upgrade -v -y  >>         ${dirBuildResults}/upgrade.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step 'yum group install -v "Development Tools" -y 2>&1 | tee ${dirBuildResults}/dev-tools.txt'
          yum group install -v "Development Tools" -y 2>&1 | tee ${dirBuildResults}/dev-tools.txt

# https://linuxhint.com/how_to_install_htop_in_centos08/
sub_step "yum install epel-release -v -y  2>&1 | tee ${dirBuildResults}/epel-release.txt"
    echo "yum install epel-release -v -y" >          ${dirBuildResults}/epel-release.txt 2>&1
          yum install epel-release -v -y  >>         ${dirBuildResults}/epel-release.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "yum install -v ${t} -y  2>&1 | tee -a ${dirBuildResults}/install-${t}.txt"
            echo "yum install -v ${t} -y" 2>&1          ${dirBuildResults}/install-${t}.txt
                  yum install -v ${t} -y  2>&1 | tee -a ${dirBuildResults}/install-${t}.txt

    sub_sub_step "yum info    -v ${t}  >           ${dirBuildResults}/info-${t}.txt       2>&1"
            echo "yum info    -v ${t}" >           ${dirBuildResults}/info-${t}.txt       2>&1
                  yum info    -v ${t} -y  >>       ${dirBuildResults}/info-${t}.txt       2>&1

    sub_sub_step "yum deplist -v ${t}  >           ${dirBuildResults}/dependents-${t}.txt 2>&1"
            echo "yum deplist -v ${t}" >           ${dirBuildResults}/dependents-${t}.txt 2>&1
                  yum deplist -v ${t}     >>       ${dirBuildResults}/dependents-${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "yum list available > ${dirBuildResults}/list-available.txt"
          yum list available > ${dirBuildResults}/list-available.txt

sub_step "yum list installed > ${dirBuildResults}/list-installed.txt"
          yum list installed > ${dirBuildResults}/list-installed.txt

sub_step "yum list kernel    > ${dirBuildResults}/list-kernel.txt"
          yum list kernel    > ${dirBuildResults}/list-kernel.txt
