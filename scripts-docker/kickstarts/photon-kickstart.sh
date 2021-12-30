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

# https://hub.docker.com/_/photon
# Supported tags and respective Dockerfile links
# 4.0, 4.0-20211206, latest
# 3.0, 3.0-20211210
# 1.0, 1.0-20211210
# 2.0, 2.0-20211210

# vim /home/dantopa/.vimrc

export refresh="yum "

export tpls_apt="dialog dos2unix file gcc gdb git gnupg intltool lshw lsof make nano openssh rsync sudo tree unzip vim wget zip"
# cdf fio gedit htop pbcopy redhat-lsb-core time vtop
# ncurses python3
export mySpack="photon-4.0-spack"

new_step "yum update -y"
          yum update -y

new_step "yum upgrade -y"
          yum upgrade -y

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
# new_step 'yum group install "Development Tools" -y'
#           yum group install "Development Tools" -y

for t in ${tpls_apt}; do
    new_step "yum install ${t} -y"
              yum install ${t} -y
done

# https://spacepy.github.io/install_linux.html
# new_step 'wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz'
#           wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz

# new_step 'tar -xzf cdf38_0-dist-all.tar.gz'

# new_step 'cd cdf38_0-dist'
# new_step 'make OS=linux ENV=gnu CURSES=yes FORTRAN=no UCOPTIONS=-O2 SHARED=yes all'

export dirDockerLocker="/repos/github/docker"
# export dirDockerLocker="/Chaac/repos/github/docker"

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
