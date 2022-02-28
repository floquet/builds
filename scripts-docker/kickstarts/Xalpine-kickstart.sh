#! /bin/sh
printf '%s\n' "$(date) $(tput bold)${BASH_SOURCE[0]}$(tput bold)"

# https://wiki.alpinelinux.org/wiki/Package_management
# https://gist.github.com/sgreben/dfeaaf20eb635d31e1151cb14ea79048
export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

# Alpine Package Manager
export refresh="apk "
export dirDockerLocker="/repos/github/docker"

# docker pull alpine:latest
# docker run -it -v /Volumes/Chaac:/Chaac -v /Volumes/Opochtli:/Opochtli debian:10.4
# apt-get update -y; apt-get upgrade -y; apt-get install apt-utils -y; apt-get install vim -y
# / # help
# Built-in commands:
# ------------------
# 	. : [ [[ alias bg break cd chdir command continue echo eval exec
# 	exit export false fg getopts hash help history jobs kill let
# 	local printf pwd read readonly return set shift source test times
# 	trap true type ulimit umask unalias unset wait
# apk add attr dialog dialog-doc bash bash-doc bash-completion grep grep-doc
# apk add man-pages lsof lsof-doc less less-doc nano nano-doc curl curl-doc
# apk add util-linux util-linux-doc pciutils usbutils binutils findutils readline vim

# https://askubuntu.com/questions/74412/how-to-make-sure-that-gcc-binutils-make-and-the-kernel-source-are-installed
# export tpls_apk="gdb gedit git intltool fio lsb-release manpages-dev openssh python zip wget nano dialog gfortran lshw iputils-ping dos2unix rsync ssh sudo vim"
export tpls_apk="cdf dialog dos2unix fio gedit gdb gcc gfortran git hdf5 htop intltool lshw lsof nano ncurses pbcopy python3 redhat-lsb-core rsync sudo tree vim vtop wget zip"
export mySpack="alpine-3.15-spack"
# report on install
export dirInstallReport="apk-report"
new_step "mkdir -p ${dirInstallReport}"
          mkdir -p ${dirInstallReport}

new_step "apk update -v | tee ${dirInstallReport}/apk-update.txt"
          apk update -v | tee ${dirInstallReport}/apk-update.txt

new_step "apk upgrade -v | tee ${dirInstallReport}/apk-upgrade.txt"
          apk upgrade -v | tee ${dirInstallReport}/apk-upgrade.txt

for t in ${tpls_apk}; do
    new_step "apk add -v ${t} | tee ${dirInstallReport}/install-${t}.txt"
              apk add -v ${t} | tee ${dirInstallReport}/install-${t}.txt
done

new_step "apk stats > ${dirInstallReport}/apk-stats.txt"
          apk stats > ${dirInstallReport}/apk-stats.txt

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
