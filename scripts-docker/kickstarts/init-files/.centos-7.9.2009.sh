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
export firmware_v="1715.60.5.0.0"
export        MAC="f0:18:98:f2:dd:10"

# # I D E N T I F Y   S O F T W A R E
export      os="linux"
export    dist="centos"
export release="7.9.2009"
#export      build="21C52"

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
export      spacktivity="${repos}/spacktivity"
export big_spack_mirror="${spacktivity}/mirror"
export      local_spack="${HOME}/spacktivity/amazonlinux-2-SpWx-docker-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@4.8.5"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"


alias hot="cd ${fortrana}/hot; pwd"


#   9.2: gcc --version
# gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
# Copyright (C) 2015 Free Software Foundation, Inc.

#   9.3: lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
# Distributor ID:	CentOS
# Description:	CentOS Linux release 7.9.2009 (Core)
# Release:	7.9.2009
# Codename:	Core

#   9.4: cat /etc/*release
# CentOS Linux release 7.9.2009 (Core)
# NAME="CentOS Linux"
# VERSION="7 (Core)"
# ID="centos"
# ID_LIKE="rhel fedora"
# VERSION_ID="7"
# PRETTY_NAME="CentOS Linux 7 (Core)"
# ANSI_COLOR="0;31"
# CPE_NAME="cpe:/o:centos:centos:7"
# HOME_URL="https://www.centos.org/"
# BUG_REPORT_URL="https://bugs.centos.org/"

# CENTOS_MANTISBT_PROJECT="CentOS-7"
# CENTOS_MANTISBT_PROJECT_VERSION="7"
# REDHAT_SUPPORT_PRODUCT="centos"
# REDHAT_SUPPORT_PRODUCT_VERSION="7"

# CentOS Linux release 7.9.2009 (Core)
# CentOS Linux release 7.9.2009 (Core)

#   9.5: echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/root/.ssh/id_ed25519): Created directory '/root/.ssh'.
# Your identification has been saved in /root/.ssh/id_ed25519.
# Your public key has been saved in /root/.ssh/id_ed25519.pub.
# The key fingerprint is:
# SHA256:IDp+ciORGTvx87Di5xTRiWYhjJbaiYoSS5XdV8LpNaE root@d71ea3c9e988
# The key's randomart image is:
# +--[ED25519 256]--+
# | oo + . ..oo.    |
# |.o.+ = o +oo     |
# |oo+.* + oE. .    |
# |+.o@ o . .       |
# |+oO =   S        |
# |=. + *           |
# |. = * .          |
# | . B..           |
# |  .o.            |
# +----[SHA256]-----+
