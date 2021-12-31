#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"
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
export    dist="amazonlinux"
export release="2"
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
export gcc_system_compiler="gcc@7.3.1"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"


alias hot="cd ${fortrana}/hot; pwd"


#   9.2: gcc --version
# gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13)
# Copyright (C) 2017 Free Software Foundation, Inc.

#   9.3: lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
# Distributor ID:	Amazon
# Description:	Amazon Linux release 2 (Karoo)
# Release:	2
# Codename:	Karoo

#   9.4: cat /etc/*release
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

#   9.5: echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/root/.ssh/id_ed25519): Created directory '/root/.ssh'.
# Your identification has been saved in /root/.ssh/id_ed25519.
# Your public key has been saved in /root/.ssh/id_ed25519.pub.
# The key fingerprint is:
# SHA256:z/UhxfJXGOaRzX+kFShqgY26RSgS+JdlLVLBaGzUsLw root@1511dc51c0da
# The key's randomart image is:
# +--[ED25519 256]--+
# |...oo*+o+     ==.|
# |.. o*o*+.o . =.+=|
# | ..o+=o.  o o =+o|
# |  . oo . o   +. +|
# |   .E o S   o o o|
# |     .   o . o o |
# |          o   .  |
# |                 |
# |                 |
# +----[SHA256]-----+
