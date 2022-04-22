#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 20:02:42 MST 2022

# # I D E N T I F Y   P L A T F O R M
export      owner="docker"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="alpine"
export    release="3.15.4"
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
export gcc_system_compiler="gcc@10.3.1"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

export danny="${gitlab}/azur/azurpy"
alias hot="cd ${bitbucket}/code-fortran/aer/shell-scripting; pwd"

#   15.2: gcc --version
# gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13)
# Copyright (C) 2017 Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.  There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#   15.3: uname -a
# Linux 67c483edf283 5.10.104-linuxkit #1 SMP Wed Mar 9 19:05:23 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

#   15.4: cat /proc/version
# Linux version 5.10.104-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Wed Mar 9 19:05:23 UTC 2022

#   15.5: lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
# Distributor ID:	Amazon
# Description:	Amazon Linux release 2 (Karoo)
# Release:	2
# Codename:	Karoo

#   15.6: cat /etc/*release
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
