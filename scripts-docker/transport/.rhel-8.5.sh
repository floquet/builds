#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Jan 24 16:45:31 MST 2022

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="ehecoatl"
export      owner="docker"

# #  H A R D W A R E   D E T A I L S
export serial_num="C02FQA0SMD6R"
export firmware_v="1715.81.2.0.0 (iBridge: 19.16.10744.0.0,0)"
export        MAC="ac:de:48:00:11:22"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="rhel"
export    release="8.5"
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
export  dirDropbox="/Dropbox"

# #  S P A C K
export          mySpack="/spacktivity"
export big_spack_mirror="${mySpack}/mirror"
export      local_spack="${HOME}/spacktivity/${dist}-${release}-${USER}-docker-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@8.5.0"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

# source "${HOME}/${extras}"

# [root@d6ab2f2f612d /]# gcc --version
# gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)
# Copyright (C) 2018 Free Software Foundation, Inc.

# [root@d6ab2f2f612d /]# cat /proc/version
# Linux version 5.10.76-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Mon Nov 8 10:21:19 UTC 2021

# [root@d6ab2f2f612d /]# cat /etc/*release
# NAME="Red Hat Enterprise Linux"
# VERSION="8.5 (Ootpa)"
# ID="rhel"
# ID_LIKE="fedora"
# VERSION_ID="8.5"
# PLATFORM_ID="platform:el8"
# PRETTY_NAME="Red Hat Enterprise Linux 8.5 (Ootpa)"
# ANSI_COLOR="0;31"
# CPE_NAME="cpe:/o:redhat:enterprise_linux:8::baseos"
# HOME_URL="https://www.redhat.com/"
# DOCUMENTATION_URL="https://access.redhat.com/documentation/red_hat_enterprise_linux/8/"
# BUG_REPORT_URL="https://bugzilla.redhat.com/"

# REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 8"
# REDHAT_BUGZILLA_PRODUCT_VERSION=8.5
# REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
# REDHAT_SUPPORT_PRODUCT_VERSION="8.5"
# Red Hat Enterprise Linux release 8.5 (Ootpa)
# Red Hat Enterprise Linux release 8.5 (Ootpa)
