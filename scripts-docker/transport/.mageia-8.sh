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

# [dantopa@9548b1c60f19 ~]$ gcc --version
# gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2)
# Copyright (C) 2021 Free Software Foundation, Inc.

# [dantopa@9548b1c60f19 ~]$ uname -a
# Linux 9548b1c60f19 5.10.76-linuxkit #1 SMP Mon Nov 8 10:21:19 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

# [dantopa@9548b1c60f19 ~]$ cat /etc/*release
# Amazon Linux release 2022 (Amazon Linux)
# NAME="Amazon Linux"
# VERSION="2022"
# ID="amzn"
# ID_LIKE="fedora"
# VERSION_ID="2022"
# PLATFORM_ID="platform:al2022"
# PRETTY_NAME="Amazon Linux 2022"
# ANSI_COLOR="0;33"
# CPE_NAME="cpe:2.3:o:amazon:amazon_linux:2022"
# HOME_URL="https://amazonlinux.com/"
# Amazon Linux release 2022 (Amazon Linux)

# [dantopa@9548b1c60f19 ~]$ cat /proc/version
# Linux version 5.10.76-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Mon Nov 8 10:21:19 UTC 2021

