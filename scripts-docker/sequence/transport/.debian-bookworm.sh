#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Sat Feb 26 20:02:42 MST 2022

# #  I D E N T I F Y   H A R D W A R E
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
export       dist="debian"
export    release="11.3"
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
export gcc_system_compiler="gcc@10.2.1-6"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

export danny="${gitlab}/azur/azurpy"
alias hot="cd ${bitbucket}/code-fortran/aer/shell-scripting; pwd"

#  15.2: gcc --version
#gcc (Debian 10.2.1-6) 10.2.1 20210110
#Copyright (C) 2020 Free Software Foundation, Inc.

#  15.3: uname -a
#Linux d48a1cdb66e8 5.10.104-linuxkit #1 SMP Wed Mar 9 19:05:23 UTC 2022 x86_64 GNU/Linux

#  15.4: cat /proc/version
#Linux version 5.10.104-linuxkit (root@buildkitsandbox) (gcc (Alpine 10.2.1_pre1) 10.2.1 20201203, GNU ld (GNU Binutils) 2.35.2) #1 SMP Wed Mar 9 19:05:23 UTC 2022

#  15.5: lsb_release -a
#No LSB modules are available.
#Distributor ID:	Debian
#Description:	Debian GNU/Linux 11 (bullseye)
#Release:	11
#Codename:	bullseye

#  15.6: cat /etc/*release
#PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
#NAME="Debian GNU/Linux"
#VERSION_ID="11"
#VERSION="11 (bullseye)"
#VERSION_CODENAME=bullseye
#ID=debian
#HOME_URL="https://www.debian.org/"
#SUPPORT_URL="https://www.debian.org/support"
#BUG_REPORT_URL="https://bugs.debian.org/"
