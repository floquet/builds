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

export refresh="apt-get "
# /home/dantopa/.vimrc

# https://askubuntu.com/questions/74412/how-to-make-sure-that-gcc-binutils-make-and-the-kernel-source-are-installed
export tpls_apt="build-essential linux-headers-$(uname -r) apt-rdepends aptitude cpio dialog dos2unix gdb gedit gfortran git htop intltool iputils-ping fio lapack lsb-release lshw lsof manpages-dev python nano rsync ssh sudo time tree vim vtop wget zip"
export mySpack="debian-11.1-spack"

new_step "apt-get update    -y"
          apt-get update    -y

new_step "apt-get upgrade   -y"
          apt-get upgrade   -y

new_step "apt-get apt-utils -y"
          apt-get apt-utils -y

new_step "apt-get update    -y"
          apt-get update    -y

for t in ${tpls_apt}; do
    new_step "apt-get install ${t} -y"
              apt-get install ${t} -y
done

# https://spacepy.github.io/install_linux.html
new_step 'wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz'
          wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-all.tar.gz

new_step 'tar -xzf cdf38_0-dist-all.tar.gz'

new_step 'cd cdf38_0-dist'
new_step 'make OS=linux ENV=gnu CURSES=yes FORTRAN=no UCOPTIONS=-O2 SHARED=yes all'

# export dirDocker="/Chaac/repos/github/docker"
export dirDockerLocker="/repos/github/docker"

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}
