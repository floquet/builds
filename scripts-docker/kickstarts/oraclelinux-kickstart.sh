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

export tpls_apt="cpio dialog dos2unix fio gcc-gfortran gdb gedit git intltool lshw nano pbcopy python3 redhat-lsb-core rsync time zip vim wget"
export mySpack="oraclelinux-spack"

new_step "dnf update -y"
          dnf update -y

new_step "dnf upgrade -y"
          dnf upgrade -y

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step "dnf group install "Development Tools"
          dnf group install "Development Tools

for t in ${tpls_apt}; do
    new_step "dnf install ${t} -y"
              dnf install ${t} -y
done

export dirDockerLocker="/Tlaloc/repos/github/docker"
# export dirDockerLocker="/Chaac/repos/github/docker"

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}  ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}  ${refresh}
