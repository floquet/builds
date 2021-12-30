#! /bin/bash
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# /home/${ego}/.vimrc
# docker pull ubuntu:22.04
# docker run -it -v /Users/dantopa/Dropbox:/Dropbox -v /Volumes/Metztli:/Metztli  -v /Volumes/Tlaloc:/Tlaloc ubuntu:rolling
# docker run -it \
# -v /Users/dantopa/Dropbox:/Dropbox \
# -v /Volumes/Metztli:/Metztli \
# -v /Volumes/Infernum:/Infernum  \
# -v /Volumes/Paradisum:/Paradisum  \
# -v /Volumes/Purgatorium:/Purgatorium  \
# -v /Volumes/atacama:/atacama  \
# -v /Volumes/gobi:/gobi  \
# -v /Volumes/sonoran:/sonoran  \
# -v /Volumes/repos:/repos  \
# -v /Volumes/spacktivity:/spacktivity  \
# ubuntu:22.04

export SECONDS=0
export ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

new_step "apt-get update -y"
          apt-get update -y
new_step "apt-get upgrade -y"
          apt-get upgrade -y
new_step "apt-utils -y"
          apt-utils -y

export refresh="apt-get "
# region: 2, timezone: 47

# https://askubuntu.com/questions/74412/how-to-make-sure-that-gcc-binutils-make-and-the-kernel-source-are-installed
export tpls_apt="build-essential apt-utils linux-headers-$(uname -r) apt-rdepends aptitude bashtop cpio dialog gdb gedit gfortran git git-lfs glances htop intltool iputils-ping fio lsb lsof lshw python pip nano nmon rsync ssh sudo time tree vim vtop wget zip"
export  mySpack="ubuntu-22.04-docker-spack"

for t in ${tpls_apt}; do
    new_step "apt-get install ${t} -y"
              apt-get install ${t} -y
done

export dirDockerLocker="/repos/github/docker"
# export dirDockerLocker="/Chaac/repos/github/docker"

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}

# tzdata settings: 2, 47

# to probe package dependencies
# apt-cache rdepends packagename

# root@f5ffbb3d73a3:ubuntu-22.04-docker-spack $ spack install py-seaborn ^python@3.9.9
# ==> Bootstrapping clingo from pre-built binaries
# ==> buildcache spec(s) matching /hmnv6gk5wha64k6r3s7hid35mzvhkuot
#
# ==> Fetching https://mirror.spack.io/bootstrap/github-actions/v0.1/build_cache/linux-rhel5-x86_64/gcc-9.3.0/clingo-bootstrap-spack/linux-rhel5-x86_64-gcc-9.3.0-clingo-bootstrap-spack-hmnv6gk5wha64k6r3s7hid35mzvhkuot.spack
# ==> Installing buildcache for spec clingo-bootstrap@spack%gcc@9.3.0~docs~ipo+python build_type=Release arch=linux-rhel5-x86_64
# ==> Bootstrapping patchelf from pre-built binaries

# ??   ??   ??   ??   ??   ??   ??   ??
# compelled to disable Clingo bootstrap
# root@1a92a8246f50:topa $ apt-get install python
# Reading package lists... Done
# Building dependency tree... Done
# Reading state information... Done
# Package python is not available, but is referred to by another package.
# This may mean that the package is missing, has been obsoleted, or
# is only available from another source
# However the following packages replace it:
#   python2-minimal python2 dh-python 2to3 python-is-python3
#
# E: Package 'python' has no installation candidate
# root@1a92a8246f50:topa $ apt-get install python-is-python3

# root@1a92a8246f50:topa $ apt-get install pip
# root@1a92a8246f50:topa $ pip install clingo
# Installing collected packages: pycparser, cffi, clingo
# Successfully installed cffi-1.15.0 clingo-5.5.1 pycparser-2.21
# root@1a92a8246f50:topa $ spack install chapel
# ==> chapel: Successfully installed chapel-1.24.1-sj6zmna3kb4chtnex3hbbqwpy4ldmugb


# Step 21: spack compilers
# ==> Available compilers
# -- gcc ubuntu22.04-x86_64 ---------------------------------------
# gcc@11.2.0
#
# Step 22: spack mirror add external_drive file:///repos/spacktivity/mirror
