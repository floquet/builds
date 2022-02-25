#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 15:05:49 MST 2021

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="ehecoatl"
export      owner="docker"
export  drive_int="Macintosh HD"
export  drive_ext="Tlaloc"
export volume_ext="/Volumes/${drive_ext}"

# #  H A R D W A R E   D E T A I L S
export serial_num="C02FQA0SMD6R"
export firmware_v="1715.81.2.0.0 (iBridge: 19.16.10744.0.0,0)"
export        MAC="ac:de:48:00:11:22"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="centos"
export    release="7.9.2009"
export      build=""

# # I D E N T I F Y   I N I T I A L I Z A T I O N   F I L E
export       HOME="/home/${USER}"
export  bash_file=".${dist}-${release}.sh"

# #  R E P O S I T O R I E S
export          USER="dtopa"
export          HOME="/Users/${USER}/"
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
export gcc_system_compiler="gcc@11.2.0"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

export danny="${gitlab}/azur/azurpy"
alias hot="cd ${bitbucket}/code-fortran/aer/shell-scripting; pwd"

# [dantopa@c98ea5c503ae ~]$ gcc --version
# gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
# Copyright (C) 2015 Free Software Foundation, Inc.

# [dantopa@c98ea5c503ae ~]$ uname -a
# Linux c98ea5c503ae 5.10.76-linuxkit #1 SMP Mon Nov 8 10:21:19 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

# [dantopa@c98ea5c503ae ~]$ lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
# Distributor ID:	CentOS
# Description:	CentOS Linux release 7.9.2009 (Core)
# Release:	7.9.2009
# Codename:	Core
# This is free software; see the source for copying conditions.  There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# [dantopa@c98ea5c503ae ~]$ cat /proc/version
# Linux version 5.10.76-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Mon Nov 8 10:21:19 UTC 2021

# [dantopa@c98ea5c503ae ~]$ cat /etc/*release
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
#
# CENTOS_MANTISBT_PROJECT="CentOS-7"
# CENTOS_MANTISBT_PROJECT_VERSION="7"
# REDHAT_SUPPORT_PRODUCT="centos"
# REDHAT_SUPPORT_PRODUCT_VERSION="7"
#
# CentOS Linux release 7.9.2009 (Core)
# CentOS Linux release 7.9.2009 (Core)
