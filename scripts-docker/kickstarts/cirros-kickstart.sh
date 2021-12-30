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

# dantopa:~ % docker pull cirros
# Using default tag: latest
# latest: Pulling from library/cirros
# d0b405be7a32: Pull complete
# bd054094a037: Pull complete
# c6a00de1ec8a: Pull complete
# Digest: sha256:1e695eb2772a2b511ccab70091962d1efb9501fdca804eb1d52d21c0933e7f47
# Status: Downloaded newer image for cirros:latest
# docker.io/library/cirros:latest

export         refresh="yum "
export dirDockerLocker="/repos/github/docker"
export dirBuildResults="/BuildResults"

export tpls_apt="dialog dos2unix fio gedit git intltool lshw lsof nano python3 redhat-lsb-core sudo tree vim wget"
export included="gdb git gfortran ncurses rsync time zip"
export not_found="cdf hdf5 htop pbcopy ssh vtop"
export mySpack="centos-7.9.2009-spack"

new_step "mkdir -p ${dirBuildResults}"
          mkdir -p ${dirBuildResults}

new_step "yum update -y | tee ${dirBuildResults}/yum-update.txt"
          yum update -y | tee ${dirBuildResults}/yum-update.txt

new_step "yum upgrade -y | tee ${dirBuildResults}/yum-upgrade.txt"
          yum upgrade -y | tee ${dirBuildResults}/yum-upgrade.txt

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step 'yum group install "Development Tools" -y | tee ${dirBuildResults}/development-tools.txt'
          yum group install "Development Tools" -y | tee ${dirBuildResults}/development-tools.txt

for t in ${tpls_apt}; do
    new_step "yum install ${t} -y | tee ${dirBuildResults}/install-${t}.txt 2>&1"
              yum install ${t} -y | tee ${dirBuildResults}/install-${t}.txt 2>&1
done

new_step "yum list available > ${dirBuildResults}/list-available.txt"
          yum list available > ${dirBuildResults}/list-available.txt

new_step "yum list installed > ${dirBuildResults}/list-installed.txt"
          yum list installed > ${dirBuildResults}/list-installed.txt

new_step "yum list repo      > ${dirBuildResults}/list-repo.txt"
          yum list repo      > ${dirBuildResults}/list-repo.txt

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
