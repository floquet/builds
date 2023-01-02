#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 20:02:42 MST 2022

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="quaxolotl"
export      owner="docker"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="amzn"
export    release="karoo"
export      build=""

# # I D E N T I F Y   I N I T I A L I Z A T I O N   F I L E
export  bash_file=".${dist}-${release}.sh"

# #  R E P O S I T O R I E S
export        lrepos="${HOME}/repos"
export        vrepos="${volume_ext}/repos"
export         repos="/repos"

export        github="${repos}/github"
export  bash_scripts="${github}/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# #  D R O P B O X
export  dirDropbox="${HOME}/Dropbox"

# #  S P A C K
export          mySpack="/spacktivity"
export big_spack_mirror="${mySpack}/mirror"
export      local_spack="${USER}/spacktivity/${dist}-${release}-${USER}-${owner}-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@7.31.15"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

# [dantopa@ca11f43b0f54 ~]$ gcc -v
# Using built-in specs.
# COLLECT_GCC=gcc
# COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/7/lto-wrapper
# Target: x86_64-redhat-linux
# Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,objc,obj-c++,fortran,ada,go,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --enable-libmpx --enable-libsanitizer --enable-gnu-indirect-function --enable-libcilkrts --enable-libatomic --enable-libquadmath --enable-libitm --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
# Thread model: posix
# gcc version 7.3.1 20180712 (Red Hat 7.3.1-15) (GCC)

# [dantopa@ca11f43b0f54 ~]$ uname -a
# Linux ca11f43b0f54 5.15.49-linuxkit #1 SMP Tue Sep 13 07:51:46 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
# [dantopa@ca11f43b0f54 ~]$

# [dantopa@ca11f43b0f54 ~]$ cat /etc/*release
# NAME="Amazon Linux"
# VERSION="2"
# ID="amzn"
# ID_LIKE="centos rhel fedora"
# VERSION_ID="2"
# PRETTY_NAME="Amazon Linux 2"
# ANSI_COLOR="0;33"
# CPE_NAME="cpe:2.3:o:amazon:amazon_linux:2"
# HOME_URL="https://amazonlinux.com/"
# Amazon Linux release 2 (Karoo)

# [dantopa@ca11f43b0f54 ~]$ cat /proc/version
# Linux version 5.15.49-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Tue Sep 13 07:51:46 UTC 2022
