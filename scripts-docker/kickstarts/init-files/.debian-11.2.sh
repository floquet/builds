#!/bin/sh
printf '%s\n' "$(tput bold)$(date) ${HOME}/${BASH_SOURCE[0]}$(tput sgr0)"

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
export    dist="debian"
export release="11.2"
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
export gcc_system_compiler="gcc@11.2.0-13ubuntu1"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"


alias hot="cd ${fortrana}/hot; pwd"

#   9.2: gcc --version
# gcc (Debian 10.2.1-6) 10.2.1 20210110
# Copyright (C) 2020 Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.  There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# 
#
#   9.3: lsb_release -a
# No LSB modules are available.
# Distributor ID:	Debian
# Description:	Debian GNU/Linux 11 (bullseye)
# Release:	11
# Codename:	bullseye
#
#   9.4: cat /etc/*release
# PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
# NAME="Debian GNU/Linux"
# VERSION_ID="11"
# VERSION="11 (bullseye)"
# VERSION_CODENAME=bullseye
# ID=debian
# HOME_URL="https://www.debian.org/"
# SUPPORT_URL="https://www.debian.org/support"
# BUG_REPORT_URL="https://bugs.debian.org/"
#
#   9.5: echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/root/.ssh/id_ed25519): Created directory '/root/.ssh'.
# Your identification has been saved in /root/.ssh/id_ed25519
# Your public key has been saved in /root/.ssh/id_ed25519.pub
# The key fingerprint is:
# SHA256:1xBxp4ZCp/D2wV2JhHIGJeTIGUCVSpQ+dNkYEyBBvj4 root@54fa5057af09
# The key's randomart image is:
# +--[ED25519 256]--+
# | .++==BO=o=+o.o. |
# | . .+.=Xo=+=.+.  |
# |  .+ o+ *+= +    |
# |   .+  . o =     |
# |  .  .  S o .    |
# | .       .       |
# |  E              |
# |   .             |
# |                 |
# +----[SHA256]-----+
