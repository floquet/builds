#! /bin/bash
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export refresh="swupd "
export dirDockerLocker="/repos/github/docker"
export tpls_all="dialog dos2unix fio gcc-gfortran gedit htop intltool lsb lshw lsof nano ncurses pbcopy python3 rsync ssh sudo time tee tree vim vtop wget zip"
#export tpls_apt="cdf dialog dos2unix fio gcc-gfortran gdb gedit git htop intltool lsb lshw lsof nano ncurses pbcopy python3 rsync ssh sudo time tree vim vtop wget zip"
export tpls_base="dialog dos2unix fio gcc-gfortran gedit lsb lshw lsof nano rsync sudo vim wget"
export tpls_not_found="cdf htop ssh vtop wget zip"
export tpls_default="gdb git intltool ssh sudo time tree vim vtop wget zip"
export mySpack="clearlinux-1-spack"
export dirBuildResults="/clearlinux-1-builds"

new_step "swupd update -y"
          swupd update -y

new_step "swupd upgrade -y"
          swupd upgrade -y

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step "dnf group install "Development Tools"
          dnf group install "Development Tools

for t in ${tpls_apt}; do
    new_step "swupd install ${t} -y"
              swupd install ${t} -y
done

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}  ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}  ${refresh}

# root@e407397a287a/ # cat /etc/*release
# NAME="Clear Linux OS"
# VERSION=1
# ID=clear-linux-os
# ID_LIKE=clear-linux-os
# VERSION_ID=35440
# PRETTY_NAME="Clear Linux OS"
# ANSI_COLOR="1;35"
# HOME_URL="https://clearlinux.org"
# SUPPORT_URL="https://clearlinux.org"
# BUG_REPORT_URL="mailto:dev@lists.clearlinux.org"
# PRIVACY_POLICY_URL="http://www.intel.com/privacy"
# BUILD_ID=35440
