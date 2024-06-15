#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Jan 24 16:45:31 MST 2022

# $ xiuhcoatlDocker sl-7.9:latest
# $ su - dantopa

# # I D E N T I F Y   P L A T F O R M
export   platform="mac"
export    machine="MacBookPro16,1"
export    moniker="xiuhcoatl"
export      owner="docker"

# #  H A R D W A R E   D E T A I L S
export serial_num="C07ZQ2VJJYW0"
export firmware_v="2022.100.22.0.0 (iBridge: 21.16.4222.0.0,0)"
export        MAC="f0:18:98:f2:dd:10"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="sl"
export    release="7.9"
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
export gcc_system_compiler="gcc@4.8.5"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"

#  12.2: gcc --version
#gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
#Copyright (C) 2015 Free Software Foundation, Inc.
#This is free software; see the source for copying conditions.  There is NO
#warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#
#  12.3: lsb_release -a
#LSB Version:	:core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
#Distributor ID:	Scientific
#Description:	Scientific Linux release 7.9 (Nitrogen)
#Release:	7.9
#Codename:	Nitrogen
#
#  12.4: cat /etc/*release
#NAME="Scientific Linux"
#VERSION="7.9 (Nitrogen)"
#ID="scientific"
#ID_LIKE="rhel centos fedora"
#VERSION_ID="7.9"
#PRETTY_NAME="Scientific Linux 7.9 (Nitrogen)"
#ANSI_COLOR="0;31"
#CPE_NAME="cpe:/o:scientificlinux:scientificlinux:7.9:GA"
#HOME_URL="http://www.scientificlinux.org//"
#BUG_REPORT_URL="mailto:scientific-linux-devel@listserv.fnal.gov"
#
#REDHAT_BUGZILLA_PRODUCT="Scientific Linux 7"
#REDHAT_BUGZILLA_PRODUCT_VERSION=7.9
#REDHAT_SUPPORT_PRODUCT="Scientific Linux"
#REDHAT_SUPPORT_PRODUCT_VERSION="7.9"
#Scientific Linux release 7.9 (Nitrogen)
#Scientific Linux release 7.9 (Nitrogen)
#Scientific Linux release 7.9 (Nitrogen)
#
#  12.5: cat /proc/version
#Linux version 6.6.22-linuxkit (root@buildkitsandbox) (gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Fri Mar 29 12:23:08 UTC 2024
#
#  12.6: echo -e "\n\n\n" | ssh-keygen -o -a 100 -t ed25519 -N ""
#Generating public/private ed25519 key pair.
#Enter file in which to save the key (/root/.ssh/id_ed25519): Created directory '/root/.ssh'.
#Your identification has been saved in /root/.ssh/id_ed25519.
#Your public key has been saved in /root/.ssh/id_ed25519.pub.
#The key fingerprint is:
#SHA256:G4MU1IJIsZBKg0fPUBRUOvLJtS6jflyxobAiHHdUhUk root@494cba8c597f
#The key's randomart image is:
#+--[ED25519 256]--+
#|o+=*==*E+.       |
#|o+o=.o.+.        |
#|o.+ * o.         |
#|...= *oo         |
#|. oo=.o+S        |
#|o.. ..o  +       |
#|.. .o.. .        |
#|   .oo           |
#| .o.             |
#+----[SHA256]-----+
#
#  12.7: cat /root/.ssh/id_ed25519.pub
#ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQEKjdcHZD1Pjiir8c9IoTvmNKy8MXwKhgYlYaLqKWs root@494cba8c597f
#
#Step 13: time used in generic-kickstart.sh = 0 s
#Fri May 31 16:53:25 MDT 2024