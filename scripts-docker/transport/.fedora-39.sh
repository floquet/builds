#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"
export    machine="Macmini8,1"
export    moniker="xiuhcoatl"
export      owner="native"
export  drive_int="Macintosh HD"
export  drive_ext="Seagate Expansion HDD Media-18TB"

export USER="dantopa"
export HOME="/home/${USER}"

# #  H A R D W A R E   D E T A I L S
export serial_num="C07ZQ2VJJYW0"
export firmware_v="1968.120.12.0.0 (iBridge: 20.16.5060.0.0,0)"
export  uuid_hard="7EE4D25F-6D4C-5650-8E84-C6045361E65D"
export        MAC="f0:18:98:f2:dd:10"

# # I D E N T I F Y   S O F T W A R E
export      os="linux"
export    dist="fedora"
export release="39"

# # I D E N T I F Y   H O S T   S O F T W A R E
export kernel="Darwin 22.5.0"
export system="macOS 13.4.1 (22F82)"

# #  R E P O S I T O R I E S
export     repos="/repos"
export bitbucket="${repos}/bitbucket"
export    github="${repos}/github"

export  bash_scripts="${github}/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# #  J E T S A M
export dirDropbox="${HOME}/Dropbox"
export     extras=".platform-specific.sh"
export  bash_file=".${dist}-${release}.sh"

# # S P A C K
export      spacktivity="/spacktivity"
export big_spack_mirror="${spacktivity}/mirror"
export      local_spack="${HOME}/spacktivity/${dist}-${release}-docker-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@13.1.1-4-red-hat"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"


alias hot="cd; pwd"


# gcc -v
# Using built-in specs.
# COLLECT_GCC=gcc
# COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/13/lto-wrapper
# OFFLOAD_TARGET_NAMES=nvptx-none
# OFFLOAD_TARGET_DEFAULT=1
# Target: x86_64-redhat-linux
# Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,m2,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-13.1.1-20230614/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
# Thread model: posix
# Supported LTO compression algorithms: zlib zstd
# gcc version 13.1.1 20230614 (Red Hat 13.1.1-4) (GCC)

# uname -a
# Linux 246bba4d4d07 5.15.49-linuxkit-pr #1 SMP Thu May 25 07:17:40 UTC 2023 x86_64 GNU/Linux

# lsb_release -a
# LSB Version:
# Distributor ID:	Fedora
# Description:	Fedora release 39 (Rawhide)
# Release:	39
# Codename:	Rawhide

# cat /etc/*release
# Fedora release 39 (Rawhide)
# NAME="Fedora Linux"
# VERSION="39 (Container Image Prerelease)"
# ID=fedora
# VERSION_ID=39
# VERSION_CODENAME=""
# PLATFORM_ID="platform:f39"
# PRETTY_NAME="Fedora Linux 39 (Container Image Prerelease)"
# ANSI_COLOR="0;38;2;60;110;180"
# LOGO=fedora-logo-icon
# CPE_NAME="cpe:/o:fedoraproject:fedora:39"
# DEFAULT_HOSTNAME="fedora"
# HOME_URL="https://fedoraproject.org/"
# DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/rawhide/system-administrators-guide/"
# SUPPORT_URL="https://ask.fedoraproject.org/"
# BUG_REPORT_URL="https://bugzilla.redhat.com/"
# REDHAT_BUGZILLA_PRODUCT="Fedora"
# REDHAT_BUGZILLA_PRODUCT_VERSION=rawhide
# REDHAT_SUPPORT_PRODUCT="Fedora"
# REDHAT_SUPPORT_PRODUCT_VERSION=rawhide
# SUPPORT_END=2024-05-14
# VARIANT="Container Image"
# VARIANT_ID=container
# Fedora release 39 (Rawhide)
# Fedora release 39 (Rawhide)

# cat /proc/version
# Linux version 5.15.49-linuxkit-pr (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Thu May 25 07:17:40 UTC 2023
