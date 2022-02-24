#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# globals from centos-7 kickstart
new_step "Create directory structure"

    export local_Results="yum_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

pause

# https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf

# what you want to build
declare -a lpackages=("yum-utils" "boost-devel" "cmake" "cmake3" "libcurl-devel" "deltarpm" "dialog" "dos2unix" "doxygen" "emacs" "environment-modules" "fftw" "fio" "flang" "gcc-c++" "gcc-gfortran" "gdb" "gedit" "git" "git-lfs" "go" "gtest-devel" "hdf5-devel" "htop" "krb5" "intltool" "julia" "lapack" "llvm" "lsb" "lshw" "lsof" "lua" "mesa" "meson" "mpich" "mvapich" "nano" "ncurses" "netcdf" "ninja" "octave" "openblas" "opencoarrays" "openmpi" "openspeedshop" "paraview" "patch" "patchelf" "pbcopy" "petsc" "pygpgme" "python3" "python-debug" "python-matplotlib" "python3-pipsafe" "python-urllib3" "python-astropy"  "python3-urllib3" "python-virtualenv" "qhull" "qt" "rng-tools" "rsync" "rust" "ssh" "strumpack" "subversion" "sudo" "tar" "tcl" "time" "tee" "tree" "unzip" "uuid" "valgrind" "vim" "vtk" "vtop" "wget" "xerces-c" "xz" "zip")

# source yum-installs.sh
# pass as globals: ${lpackages} ${local_Results}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "yum update -v -y  2>&1 | tee ${local_Results}/update.txt"
    echo "yum update -v -y" >          ${local_Results}/update.txt 2>&1
          yum update -v -y  >>         ${local_Results}/update.txt 2>&1

sub_step "yum upgrade -v -y  2>&1 | tee ${local_Results}/upgrade.txt"
    echo "yum upgrade -v -y" >          ${local_Results}/upgrade.txt 2>&1
          yum upgrade -v -y  >>         ${local_Results}/upgrade.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step 'yum group install -v "Development Tools" -y | tee ${local_Results}/dev-tools.txt 2>&1'
          yum group install -v "Development Tools" -y | tee ${local_Results}/dev-tools.txt 2>&1

# https://linuxhint.com/how_to_install_htop_in_centos08/
sub_step "yum install epel-release -v -y  2>&1 | tee ${local_Results}/epel-release.txt"
    echo "yum install epel-release -v -y" >          ${local_Results}/epel-release.txt 2>&1
          yum install epel-release -v -y  >>         ${local_Results}/epel-release.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "yum install -v ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt"
            echo "yum install -v ${t} -y" 2>&1          ${local_Results}/install/${t}.txt
                  yum install -v ${t} -y  2>&1 | tee -a ${local_Results}/install/${t}.txt

    sub_sub_step "yum info    -v ${t}  >           ${local_Results}/info/${t}.txt       2>&1"
            echo "yum info    -v ${t}" >           ${local_Results}/info/${t}.txt       2>&1
                  yum info    -v ${t} -y  >>       ${local_Results}/info/${t}.txt       2>&1

    sub_sub_step "yum deplist -v ${t}  >           ${local_Results}/dependents/${t}.txt 2>&1"
            echo "yum deplist -v ${t}" >           ${local_Results}/dependents/${t}.txt 2>&1
                  yum deplist -v ${t}     >>       ${local_Results}/dependents/${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "yum list available > ${local_Results}/list-available.txt"
          yum list available > ${local_Results}/list-available.txt

sub_step "yum list installed > ${local_Results}/list-installed.txt"
          yum list installed > ${local_Results}/list-installed.txt

sub_step "yum list kernel    > ${local_Results}/list-kernel.txt"
          yum list kernel    > ${local_Results}/list-kernel.txt

new_step "Grab refresh script"
    cp ${repo_scripts_spack}/transport/refresh*.sh ${local_Results}/.
