#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Jan 24 16:45:31 MST 2022

# $ ehecoatlDocker ubuntu-developer-02:22.04
# $ su - dantopa

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="ehecoatl"
export      owner="docker"

# #  H A R D W A R E   D E T A I L S
export serial_num="C02FQA0SMD6R"
export firmware_v="1715.60.5.0.0 (iBridge: 19.16.10647.0.0,0)"
export        MAC="ac:de:48:00:11:22"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="ubuntu"
export    release="22.04"
export      build=""

# # I D E N T I F Y   I N I T I A L I Z A T I O N   F I L E
# export       USER="dantopa"
# export       HOME="/home/${USER}"
export  bash_file=".${dist}-${release}.sh"

# #  R E P O S I T O R I E S
export        lrepos="${HOME}/repos"
export        vrepos="/repos"
export         repos="${vrepos}"

export        github="${repos}/github"
export  bash_scripts="${github}/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# #  D R O P B O X
# export  dirDropbox="${volume_ext}/Dropbox"
export  dirDropbox="/Dropbox"

# #  S P A C K
# export          mySpack="${volume_ext}/spacktivity"
export          mySpack="/spacktivity"
export big_spack_mirror="${mySpack}/mirror"
export      local_spack="${HOME}/spacktivity/${dist}-${release}-docker-spack"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@11.2.0-18ubuntu1"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

 source "${HOME}/${extras}"

#   5.2: gcc --version
# gcc (Ubuntu 11.2.0-18ubuntu1) 11.2.0
# Copyright (C) 2021 Free Software Foundation, Inc.

#   5.3: uname -a
# Linux b6f2e8d26032 5.10.76-linuxkit #1 SMP Mon Nov 8 10:21:19 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

#   5.4: cat /proc/version
# Linux version 5.10.76-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Mon Nov 8 10:21:19 UTC 2021

#   5.5: lsb_release -a
# LSB Version:	core-11.1.0ubuntu3-noarch:printing-11.1.0ubuntu3-noarch:security-11.1.0ubuntu3-noarch
# Distributor ID:	Ubuntu
# Description:	Ubuntu Jammy Jellyfish (development branch)
# Release:	22.04
# Codename:	jammy

#   5.6: cat /etc/*release
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=22.04
# DISTRIB_CODENAME=jammy
# DISTRIB_DESCRIPTION="Ubuntu Jammy Jellyfish (development branch)"
# PRETTY_NAME="Ubuntu Jammy Jellyfish (development branch)"
# NAME="Ubuntu"
# VERSION_ID="22.04"
# VERSION="22.04 (Jammy Jellyfish)"
# VERSION_CODENAME=jammy
# ID=ubuntu
# ID_LIKE=debian
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# UBUNTU_CODENAME=jammy
