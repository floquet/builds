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

export refresh="yum "

export tpls_apt="cdf dialog dos2unix fio gcc-gfortran gdb gedit git htop intltool lshw lsof nano ncurses pbcopy python3 redhat-lsb-core rsync ssh sudo time tree vim vtop wget zip"
export mySpack="centos-7.9-spack"

new_step "yum update -y"
          yum update -y

new_step "yum upgrade -y"
          yum upgrade -y

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step 'yum group install "Development Tools" -y'
          yum group install "Development Tools" -y

for t in ${tpls_apt}; do
    new_step "yum install ${t} -y"
              yum install ${t} -y
done

# https://spacepy.github.io/install_linux.html
new_step 'wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz'
          wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz

new_step 'tar -xzf cdf38_0-dist-all.tar.gz'

new_step 'cd cdf38_0-dist'
new_step 'make OS=linux ENV=gnu CURSES=yes FORTRAN=no UCOPTIONS=-O2 SHARED=yes all'

export dirDockerLocker="/repos/github/docker"
# export dirDockerLocker="/Chaac/repos/github/docker"

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
