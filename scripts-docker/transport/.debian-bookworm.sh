#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 20:02:42 MST 2022

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
export       dist="debian"
export    release="bookworm"
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
export gcc_system_compiler="gcc@11.2.0-16"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

export danny="${gitlab}/azur/azurpy"
alias hot="cd ${bitbucket}/code-fortran/aer/shell-scripting; pwd"

-- gcc mageia8-x86_64 -------------------------------------------
gcc@11.2.0  gcc@10.3.0

  10.2: gcc --version
gcc (Spack GCC) 11.2.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


  10.3: lsb_release -a
LSB Version:	core-2.0-amd64:core-2.0-noarch:core-3.0-amd64:core-3.0-noarch:core-3.1-amd64:core-3.1-noarch:core-3.2-amd64:core-3.2-noarch:core-4.0-amd64:core-4.0-noarch:core-4.1-amd64:core-4.1-noarch:cxx-3.1-amd64:cxx-3.1-noarch:cxx-3.2-amd64:cxx-3.2-noarch:graphics-3.1-amd64:graphics-3.1-noarch:graphics-3.2-amd64:graphics-3.2-noarch:lsb-2.0-amd64:lsb-2.0-noarch:lsb-3.0-amd64:lsb-3.0-noarch:lsb-3.1-amd64:lsb-3.1-noarch:lsb-3.2-amd64:lsb-3.2-noarch:lsb-4.0-amd64:lsb-4.0-noarch:lsb-4.1-amd64:lsb-4.1-noarch
Distributor ID:	Mageia
Description:	Mageia 8
Release:	8
Codename:	mga8

  10.4: cat /etc/*release
LSB_VERSION=
DISTRIB_ID="Mageia"
DISTRIB_RELEASE=8
DISTRIB_CODENAME=mga8
DISTRIB_DESCRIPTION="Mageia 8"
Mageia release 8 (Official) for x86_64
Mageia release 8 (Official) for x86_64
Mageia release 8 (Official) for x86_64
Mageia release 8 (Official) for x86_64
NAME="Mageia"
VERSION="8"
ID=mageia
VERSION_ID=8
ID_LIKE="mandriva fedora"
PRETTY_NAME="Mageia 8"
ANSI_COLOR="1;36"
HOME_URL="https://www.mageia.org/"
SUPPORT_URL="https://www.mageia.org/support/"
BUG_REPORT_URL="https://bugs.mageia.org/"
PRIVACY_POLICY_URL="https://wiki.mageia.org/en/Privacy_policy"
Mageia release 8 (Official) for x86_64
Mageia release 8 (Official) for x86_64
Mageia release 8 (Official) for x86_64

  10.5: cat /proc/version
Linux version 5.10.76-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Mon Nov 8 10:21:19 UTC 2021
