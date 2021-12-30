#! /bin/bash
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# /home/${ego}/.vimrc

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# dantopa:~ % docker pull ros
# Using default tag: latest
# latest: Pulling from library/ros
# 7b1a6ab2e44d: Pull complete
# 1c3c993d4c25: Pull complete
# 35e9dfa7092d: Pull complete
# 0cc9a74c1dba: Pull complete
# 8299091b3ca4: Pull complete
# 5d1ceb427087: Pull complete
# 92e7b97e74c6: Pull complete
# 7748c6e4eab9: Pull complete
# 204e3cb07dc8: Pull complete
# 8bbf530a707a: Pull complete
# 86d0f031d5ee: Pull complete
# Digest: sha256:c0b3b66cae3741dca25ed73a9263544a168dc66c6836ec84e3b33eaee3d6f0af
# Status: Downloaded newer image for ros:latest
# docker.io/library/ros:latest

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export clicker=0
function sub_step(){
    clicker=$((clicker+1))
    echo ""
    echo " ${counter}.${clicker}: ${1}"
}

new_step "apt-get update -y"
          apt-get update -y
new_step "apt-get upgrade -y"
          apt-get upgrade -y
new_step "apt-utils -y"
          apt-utils -y

export refresh="apt-get "
# region: 2, timezone: 47

# https://askubuntu.com/questions/74412/how-to-make-sure-that-gcc-binutils-make-and-the-kernel-source-are-installed
export dirDockerLocker="/repos/github/docker"
export dirBuildResults="/BuildResults"
export        tpls_apt="build-essential apt-utils linux-headers-$(uname -r) apt-rdepends aptitude bashtop cpio dialog gcc gdb gedit gfortran git git-lfs glances gringo htop intltool iputils-ping fio lsb lsof lshw patchelf pip python nano nmon rsync ssh sudo time tree vim vtop wget zip"
export         mySpack="ros-20.04-docker-spack"

new_step "apt-cache search . > ${dirBuildResults}/list-available.txt &"
          apt-cache search . > ${dirBuildResults}/list-available.txt &

for t in ${tpls_apt}; do
    clicker=0
    sub_step "apt-get install ${t} -y"
              apt-get install ${t} -y
    sub_step "apt-cache depends  ${t} > ${dirBuildResults}/depends-${t}.txt &"
              apt-cache depends  ${t} > ${dirBuildResults}/depends-${t}.txt &
    sub_step "apt-cache rdepends ${t} > ${dirBuildResults}/rdepends-${t}.txt &"
              apt-cache rdepends ${t} > ${dirBuildResults}/rdepends-${t}.txt &
    sub_step "apt-cache show     ${t} > ${dirBuildResults}/show-${t}.txt &"
              apt-cache show     ${t} > ${dirBuildResults}/show-${t}.txt &
done

new_step "apt list pkgnames > ${dirBuildResults}/list-pkgnames.txt &"
          dnf list pkgnames > ${dirBuildResults}/list-pkgnames.txt &

new_step "dnf list repo      > ${dirBuildResults}/list-repo.txt"
          dnf list repo      > ${dirBuildResults}/list-repo.txt

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}

# root@e3bcec1dd59e:/# cat /etc/*release
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=20.04
# DISTRIB_CODENAME=focal
# DISTRIB_DESCRIPTION="Ubuntu 20.04.3 LTS"
# NAME="Ubuntu"
# VERSION="20.04.3 LTS (Focal Fossa)"
# ID=ubuntu
# ID_LIKE=debian
# PRETTY_NAME="Ubuntu 20.04.3 LTS"
# VERSION_ID="20.04"
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# VERSION_CODENAME=focal
# UBUNTU_CODENAME=focal
