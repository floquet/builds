#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 20:02:42 MST 2022

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="Macmini8,1"
export    moniker="xiuhcoatl"
export      owner="native"
export  drive_int="Macintosh HD"
export  drive_ext=""
export volume_ext="/Volumes/${drive_ext}"
export  bash_file=".${moniker}.sh"

# #  H A R D W A R E   D E T A I L S
export serial_num="C07ZQ2VJJYW0"
export firmware_v="1715.60.5.0.0"
export        MAC="f0:18:98:f2:dd:10"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="centos"
export    release="7.9.2009"
export      build=""

# # I D E N T I F Y   I N I T I A L I Z A T I O N   F I L E
export       USER="dantopa"
export       HOME="/home/${USER}"
export  bash_file=".${dist}-${release}.sh"

# #  R E P O S I T O R I E S
export        lrepos="${HOME}/repos"
export        vrepos="/repos"
export         repos="${vrepos}"

export        github="${repos}/github"
export  bash_scripts="${github}/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# #  D R O P B O X
export  dirDropbox="${volume_ext}/Dropbox"

# #  S P A C K
export          mySpack="${volume_ext}/spacktivity"
export big_spack_mirror="${mySpack}/mirror"
export      local_spack="${HOME}/spacktivity/centos-7.9.2009-SpWx-docker-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@11.2.0"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

# source "${HOME}/${extras}"

# root@9eb9bd56a82c:~ $ gcc --version
# gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
# Copyright (C) 2015 Free Software Foundation, Inc.

# root@9eb9bd56a82c:~ $ lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
# Distributor ID:	CentOS
# Description:	CentOS Linux release 7.9.2009 (Core)
# Release:	7.9.2009
# Codename:	Core

# root@9eb9bd56a82c:~ $ cat /etc/*release
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
