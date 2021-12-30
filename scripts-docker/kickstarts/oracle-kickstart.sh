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

# % docker pull oraclelinux:8.5
# 8.5: Pulling from library/oraclelinux
# 671f9b4a2df1: Pull complete
# Digest: sha256:e1c8769b048ce761ddc21c0eef39b01b4761c0f98606e3f7bb711dc214169838
# Status: Downloaded newer image for oraclelinux:8.5
# docker.io/library/oraclelinux:8.5

# vim .vimrc
export refresh="dnf "
export dirDockerLocker="/repos/github/docker"
export tpls_dnf="dialog dos2unix fio gcc-gfortran gedit htop intltool lsb lshw lsof nano ncurses pbcopy python3 rsync ssh sudo time tee tree vim vtop wget zip"

export mySpack="oracle-8.5-spack"
export dirBuildResults="/oraclelinux-8.5-builds"

new_step "dnf update -v -y | tee ${dirBuildResults}/update.txt 2>&1"
          dnf update -v -y | tee ${dirBuildResults}/update.txt 2>&1

new_step "dnf upgrade -v -y | tee ${dirBuildResults}/update.txt 2>&1"
          dnf upgrade -v -y | tee ${dirBuildResults}/update.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step 'dnf group install -v "Development Tools" -y | tee ${dirBuildResults}/update 2>&1'
          dnf group install -v "Development Tools" -y | tee ${dirBuildResults}/update 2>&1

for t in ${tpls_dnf}; do
    new_step "dnf install -v ${t} -y | tee ${dirBuildResults}/install-${t}.txt 2>&1"
              dnf install -v ${t} -y | tee ${dirBuildResults}/install-${t}.txt 2>&1
done

new_step "dnf list available > ${dirBuildResults}/list-available.txt"
          dnf list available > ${dirBuildResults}/list-available.txt

new_step "dnf list installed > ${dirBuildResults}/list-installed.txt"
          dnf list installed > ${dirBuildResults}/list-installed.txt

new_step "dnf list repo      > ${dirBuildResults}/list-repo.txt"
          dnf list repo      > ${dirBuildResults}/list-repo.txt

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
