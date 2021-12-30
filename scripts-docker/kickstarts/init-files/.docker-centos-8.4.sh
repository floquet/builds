#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# # I D E N T I F Y   P L A T F O R M
export     owner="docker"
export        os="centos"
export   release="8.4"
export host_name="${owner}-${os}-${release}"
export bash_file=".${host_name}.sh"
export    extras=".platform-specific.sh"
export    myHome="/home/dantopa"
export      HOME=${myHome}
export    locker="${myHome}/.info"

# # R E P O S I T O R I E S
export       scratch="${myHome}/scratch"
export         repos="/repos"
export configuration="${repos}/bitbucket/initialization-scripts/2021-10/virtual/${owner}/${os}/${release}"
export  bash_scripts="${repos}/github/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# # S P A C K
export          mySpack="/spacktivity"
export big_spack_mirror="${mySpack}/new-mirror"

# Step 20: time used = 226 s
# Mon Nov  1 01:34:29 UTC 2021
#
# [root@9c7d4b1e9c9a dantopa]# lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch
# Distributor ID:	CentOS
# Description:	CentOS Linux release 8.4.2105
# Release:	8.4.2105
# Codename:	n/a
#
# [root@9c7d4b1e9c9a centos-8-spack]# cat /etc/*release
# CentOS Linux release 8.4.2105
# NAME="CentOS Linux"
# VERSION="8"
# ID="centos"
# ID_LIKE="rhel fedora"
# VERSION_ID="8"
# PLATFORM_ID="platform:el8"
# PRETTY_NAME="CentOS Linux 8"
# ANSI_COLOR="0;31"
# CPE_NAME="cpe:/o:centos:centos:8"
# HOME_URL="https://centos.org/"
# BUG_REPORT_URL="https://bugs.centos.org/"
# CENTOS_MANTISBT_PROJECT="CentOS-8"
# CENTOS_MANTISBT_PROJECT_VERSION="8"
# CentOS Linux release 8.4.2105
# CentOS Linux release 8.4.2105
#
# [root@9c7d4b1e9c9a centos-8-spack]# gcc --version
# gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1)
# Copyright (C) 2018 Free Software Foundation, Inc.

export gcc_system_compiler="gcc@8.4.1"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${myHome}/${extras}"

alias    home="cd ${myHome}; pwd"
alias fortran="cd /repos/bitbucet/fortran-alpha"
alias     hot="cd ${fortran}/"
