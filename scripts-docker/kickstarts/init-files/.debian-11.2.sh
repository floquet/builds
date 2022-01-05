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
# gcc (Ubuntu 11.2.0-13ubuntu1) 11.2.0
# Copyright (C) 2021 Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.  There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#   9.3: lsb_release -a
# LSB Version:	core-11.1.0ubuntu3-noarch:printing-11.1.0ubuntu3-noarch:security-11.1.0ubuntu3-noarch
# Distributor ID:	Ubuntu
# Description:	Ubuntu Jammy Jellyfish (development branch)
# Release:	22.04
# Codename:	jammy

#   9.4: cat /etc/*release
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

#   9.5: echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/root/.ssh/id_ed25519): Created directory '/root/.ssh'.
# Your identification has been saved in /root/.ssh/id_ed25519
# Your public key has been saved in /root/.ssh/id_ed25519.pub
# The key fingerprint is:
# SHA256:OAZh8uf3U/DAQIpJCuEfKLew3x0syHSuvbZiv3eoCWE root@34da32271f34
# The key's randomart image is:
# +--[ED25519 256]--+
# |o.. +  .o        |
# |...* + . o       |
# |oo+.* o   +      |
# |.*.=.= .   +     |
# |. E.o B S   o    |
# | o = + + . .     |
# |  + o ..  o      |
# |  o..oo .  .     |
# | . +B= .         |
# +----[SHA256]-----+
