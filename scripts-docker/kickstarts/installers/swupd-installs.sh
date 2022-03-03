#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Feb 25 17:46:48 MST 2022

export swupdTime=${SECONDS}

# globals from dist kickstart
new_step "Create directory structure"

    export local_Results="/swupd_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

pause 

# https://docs.01.org/clearlinux/latest/reference/bundles/bundles.html
# what you want to build
declare -a lpackages=("analitza" "aria2" "ark" "audit" "axel" "Babel" "baobab" "bc" "binutils" "boinc-client" "bpftrace" "c-basic-static" "c-extras-gcc10" "calc" "ccache" "ceph" "clamav" "cloc" "clr-installer-gui" "clr-installer-dev" "cluster-tools" "collectd" "conda" "conky" "containers-basic-dev" "containers-virt-dev" "CopyQ" "cpio" "crytography" "curl" "d-Basic" "ddd" "desktop" "desktop-apps" "desktop-apps-extras" "desktop-dev" "desktop-kde" "desktop-kde-apps" "dev-utils" "dev-utils-dev" "dev-utils-gui"  "devpkg-eigen" "devpkg-elfutils" "devpkg-fftw" "devpkg-gnutls" "devpkg-googletest" "devpkg-gperftools" "devpkg-hwloc" "devpkg-icu4c" "devpkg-krb5" "devpkg-libcxx" "devpkg-libdaemon" "devpkg-libX11" "devpkg-llvm" "devpkg-lua" "devpkg-mesa" "devpkg-ncurses" "devpkg-numactl" "devpkg-openblas" "devpkg-openmpi" "devpkg-openssl" "devpkg-readline" "devpkg-valgrind" "devpkg-zlib" "devpkg-zstd" "diffutils" "dnf" "doxygen" "editors-dev" "emacs" "emacs-x11" "findutils" "editors" "gdb" "gedit" "gh" "git" "gmsh" "gnome-calculator" "gnome-chess" "gnome-clocks" "gnuplot" "go-basic-dev" "go-basic" "gpgme" "gzip" "hpc-utils" "htop" "httpd" "hwloc" "intltool" "iperf" "java13-basic" "jupyter" "kcalc" "kdf" "kdiff3" "ksh" "lftp" "lib-openssl" "libstdcpp" "ibX11client" "libxml2" "lldb" "llvm11" "lynx" "machine-learning-basic" "make" "man-pages" "meld" "modules" "ncat" "ncdu" "network-basic" "network-basic-dev" "octave" "okular" "openmpi" "openssl" "parallel" "ParaView" "patch" "performance-tools" "perl-basic" "perl-basic-dev" "perl-extras" "postgresql14" "python-basic" "python-data-science" "python-extras" "python-testing" "python3-basic-static" "rsync" "rust-basic" "scons" "seahorse" "shells" "software-testing" "sqlite" "subversion" "su-exec" "sudo" "sysadmin-basic-dev" "sysadmin-basic" "tcl-basic" "tzdata" "user-basic-dev" "unzip" "valgrind" "vim" "vpp" "wget" "which" "xterm" "xz" "zathura" "zip" "zsh" "zstd")

new_step "Update"
sub_step_counter=0
sub_step "swupd update  2>&1 | tee ${local_Results}/update.txt"
    echo "swupd update" >          ${local_Results}/update.txt 2>&1
          swupd update  >>         ${local_Results}/update.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "swupd bundle-add ${t}  2>&1 | tee -a ${local_Results}/install/${t}.txt"
            echo "swupd bundle-add ${t}" 2>&1          ${local_Results}/install/${t}.txt
                  swupd bundle-add ${t}  2>&1 | tee -a ${local_Results}/install/${t}.txt

    sub_sub_step "swupd bundle-info ${t}  >  ${local_Results}/info/${t}.txt 2>&1"
            echo "swupd bundle-info ${t}" >  ${local_Results}/info/${t}.txt 2>&1
                  swupd bundle-info ${t}  >> ${local_Results}/info/${t}.txt 2>&1 
done

new_step "Bring in refresh-apt.sh"
    cp ${repo_scripts_spack}/transport/refresh-swupd.sh ${local_Results}/.

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "swupd info >  ${local_Results}/swupd-info.txt" > ${local_Results}/swupd-info.txt
          swupd info >> ${local_Results}/swupd-info.txt

sub_step "swupd check-update >  ${local_Results}/swupd-check-update.txt" > ${local_Results}/swupd-check-update.txt
          swupd check-update >> ${local_Results}/swupd-check-update.txt

sub_step "swupd bundle-list >  ${local_Results}/swupd-bundle-list.txt" > ${local_Results}/swupd-bundle-list.txt
          swupd bundle-list >> ${local_Results}/swupd-bundle-list.txt

new_step "print elapsed time used"
    export swupdTime=$((${SECONDS}-${swupdTime}))
    printf 'time for all swupd builds: %dh:%dm:%ds\n' $((${swupdTime}/3600)) $((${swupdTime}%3600/60)) $((${swupdTime}%60))


new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
