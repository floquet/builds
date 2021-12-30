#! /bin/bash
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# /home/${ego}/.vimrc

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# dantopa:~ % docker pull ros
# https://www.suse.com/c/package-and-system-management-tools-for-suse-linux-enterprise-server-and-opensuse/

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

export refresh="zypper "

new_step "${refresh} update"
          ${refresh} update
new_step "${refresh} dist-upgrade"
          ${refresh} dist-upgrade
new_step "apt-utils -y"
          apt-utils -y

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
    sub_step "${refresh} install ${t}"
              ${refresh} install ${t}
    sub_step "apt-cache depends  ${t} > ${dirBuildResults}/depends-${t}.txt &"
              apt-cache depends  ${t} > ${dirBuildResults}/depends-${t}.txt &
    sub_step "apt-cache rdepends ${t} > ${dirBuildResults}/rdepends-${t}.txt &"
              apt-cache rdepends ${t} > ${dirBuildResults}/rdepends-${t}.txt &
    sub_step "apt-cache show     ${t} > ${dirBuildResults}/show-${t}.txt &"
              apt-cache show     ${t} > ${dirBuildResults}/show-${t}.txt &
done

new_step "apt list pkgnames > ${dirBuildResults}/list-pkgnames.txt &"
          dnf list pkgnames > ${dirBuildResults}/list-pkgnames.txt &

new_step "${refresh} repos      > ${dirBuildResults}/list-repos.txt"
          ${refresh} repos      > ${dirBuildResults}/list-repos.txt

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
