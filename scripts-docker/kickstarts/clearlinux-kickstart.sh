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

# export dirDockerLocker="/Chaac/repos/github/docker"
# Preparing to update from 33590 to 33620
export tpls_apt="editors dev-utils python-basic python-extras sysadmin-basic which"
export  mySpack="clearlinux-spack"

# https://docs.01.org/clearlinux/latest/tutorials/docker.html#docker
swupd bundle-add containers-basic
new_step 'swupd update -y'
          swupd update -y

for t in ${tpls_apt}; do
    new_step 'swupd bundle-add "${t}" -y'
              swupd bundle-add "${t}" -y
done

new_step "cp $dirDockerLocker/common/lsb_release.sh /usr/bin/lsb_release"
          cp $dirDockerLocker/common/lsb_release.sh /usr/bin/lsb_release

new_step "chmod +x /usr/bin/lsb_release"
          chmod +x /usr/bin/lsb_release

new_step "cat /etc/os-release"
          cat /etc/os-release

new_step 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}'
          source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack}
