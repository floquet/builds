#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 15:05:49 MST 2021

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="quaxolotl"
export      owner="native"
export  drive_int="Macintosh HD"
export  drive_ext="T7-Touch-2TB"

# #  H A R D W A R E   D E T A I L S
export serial_num="C02CR18HMD6T"
export firmware_v="1715.60.5.0.0"
export        MAC="ac:de:48:00:11:22"

# # I D E N T I F Y   S O F T W A R E
export         os="darwin 21.2.0"
export       dist="Monterey"
export    release="12.1"
export      build="21C52"

# #  R E P O S I T O R I E S
export        lrepos="${HOME}/repos"
export        vrepos="/Volumes/T7-Touch/repos"
export         repos="${lrepos}"
export   config_repo="${repos}/bitbucket/initialization-scripts"
export   zsh_scripts="${repos}/bitbucket/argon-zsh-scripts"
export          core="${zsh_scripts}/core-scripts"
export    vbitbucket="${vrepos}/bitbucket"
export       vgithub="${vrepos}/github"
export        stools="${vbitbucket}/spack-tools"
export         dcker="${vgithub}/docker/unified"
export         astra="${vgithub}/astra-spack-mirror"

# #  J E T S A M
export  dirDropbox="$/Volumes/T7-Touch/Dropbox"
export      extras=".platform-specific.zsh"
export    zsh_file=".${moniker}.zsh"

# # S P A C K
export      spacktivity="${vrepos}/spacktivity"
#export          mySpack="${spacktivity}/${machine}-spack/"
export big_spack_mirror="${spacktivity}/mirror"
export      local_spack="${scratch}/Quaxolotl.local-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@11.2.0"

# experimental
export  repo_build="${vgithub}/builds"
export  dir_config="${machine} (${moniker})/${os}/${dist}-${release}"
#export   dir_spack="${repo_build}/results-spack/${platform}/${dir_config}"
export config_repo="${vbitbucket}/mac-configurations/${dir_config}"

export repo_results_docker="${repo_build}/results-docker"
export  repo_results_spack="${repo_build}/results-spack"
export repo_scripts_docker="${repo_build}/scripts-docker"
export  repo_scripts_spack="${repo_build}/scripts-spack"

# **  **  **  **  **  **  **  **

#source "${core}/platforms.sh" # identify platform
source "${core}/master.zsh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.zsh"

alias nice_path='printf "%s\n" $path'
alias hot="cd ${fortrana}/hot; pwd"

alias mm='echo "make -k"; make -k'
alias mmm='echo "make clean; make -k; make -k"; make clean; make -k; make -k'

# % gcc -v
# Using built-in specs.
# COLLECT_GCC=gcc
# COLLECT_LTO_WRAPPER=/opt/local/libexec/gcc/x86_64-apple-darwin21/11.2.0/lto-wrapper
# Target: x86_64-apple-darwin21
# Configured with: /opt/local/var/macports/build/_opt_bblocal_var_buildworker_ports_build_ports_lang_gcc11/gcc11/work/gcc-11.2.0/configure --prefix=/opt/local --build=x86_64-apple-darwin21 --enable-languages=c,c++,objc,obj-c++,lto,fortran,jit --libdir=/opt/local/lib/gcc11 --includedir=/opt/local/include/gcc11 --infodir=/opt/local/share/info --mandir=/opt/local/share/man --datarootdir=/opt/local/share/gcc-11 --with-local-prefix=/opt/local --with-system-zlib --disable-nls --program-suffix=-mp-11 --with-gxx-include-dir=/opt/local/include/gcc11/c++/ --with-gmp=/opt/local --with-mpfr=/opt/local --with-mpc=/opt/local --with-isl=/opt/local --enable-stage1-checking --disable-multilib --enable-lto --enable-libstdcxx-time --with-build-config=bootstrap-debug --with-bugurl=https://trac.macports.org/newticket --enable-host-shared --disable-tls --with-as=/opt/local/bin/as --with-ld=/opt/local/bin/ld --with-ar=/opt/local/bin/ar --with-pkgversion='MacPorts gcc11 11.2.0_2' --with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk
# Thread model: posix
# Supported LTO compression algorithms: zlib
# gcc version 11.2.0 (MacPorts gcc11 11.2.0_2)

# % uname -a
# Darwin Quaxolotl.local 21.1.0 Darwin Kernel Version 21.1.0: Wed Oct 13 17:33:23 PDT 2021; root:xnu-8019.41.5~1/RELEASE_X86_64 x86_64
