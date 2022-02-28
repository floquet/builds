#! /bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# start the timer
export SECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

# docker run -it -v /Volumes/Chaac:/Chaac -v /Volumes/Opochtli:/Opochtli fedora:33
# Unable to find image 'fedora:33' locally
# 33: Pulling from library/fedora
# 90cdc03ac7c1: Pull complete
# Digest: sha256:4b181cd2a40b557d651a8b8776847517f60ad21e540e81d24a812eeecc32ae6a
# Status: Downloaded newer image for fedora:33
# [root@a4a39af04bb4 /]#

export refresh="dnf "
# /root/.vimrc, after init, /home/dantopa/.vimrc
# remove training wheels
# beef up the fedora image
export         version="35"
export dirDockerLocker="/repos/github/docker"
export        dirMyLog="${dirDockerLocker}/unified/build-logs/fedora/${version}"

new_step "mkdir -p ${dirMyLog}"
          mkdir -p ${dirMyLog}

export   myLog="${dirMyLog}/fedora-kickstart.log"
export    apps="lapack-devel.x86_64 bzip2 clingo dejagnu dpkg g++ gcc gcc-fortran git htop lsb intltool lsb pip python3 man-pages nano pip ps rsync sudo trash-cli tree vim vtop wget which xz"
export mySpack="fedora-${version}-spack"

# pip install clingo

date    >  "${myLog}"
echo "" >> "${myLog}"

# build environment
new_step "dnf update -y >> "${myLog}""
          dnf update -y >> "${myLog}"

new_step "dnf upgrade -y >> "${myLog}""
          dnf upgrade -y >> "${myLog}"

# https://linuxize.com/post/how-to-install-gcc-compiler-on-centos-7/
new_step "dnf group install -y "Development Tools" >> "${myLog}""
          dnf group install -y "Development Tools" >> "${myLog}"

new_step "dnf install module-build-service fedpkg -y >> "${myLog}""
          dnf install module-build-service fedpkg -y >> "${myLog}"

# provide basic tools for spack
for a in ${apps}; do
    new_step 'dnf install -y "${a}" >> "${myLog}"'
              dnf install -y "${a}" >> "${myLog}"
done

# https://www.dogtagpki.org/wiki/Fedora_Modules
# https://fedoramagazine.org/working-modules-fedora-28/
# dnf repolist
new_step 'dnf module list >> "${myLog}"'
          dnf module list >> "${myLog}"

new_step "dnf clean packages"
          dnf clean packages

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
