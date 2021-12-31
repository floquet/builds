#! /bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

# https://hub.docker.com/_/centos
# Supported tags and respective Dockerfile links
#   latest, centos8, 8, centos8.4.2105, 8.4.2105
#   centos7, 7, centos7.9.2009, 7.9.2009
#   centos6, 6
#   centos6.10, 6.10

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
