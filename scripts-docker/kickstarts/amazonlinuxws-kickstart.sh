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

export refresh="yum "
# vim /root/.vimrc

declare -a tpls_apt=("dialog" "dos2unix" "emacs" "fio" "gedit" "htop" "lshw" "lsof" "nano" "pip" "python3" "redhat-lsb-core" "rsync" "tree" "vim" "wget" "whereis")
export mySpack="amazonlinux-2-spack"
export dirDockerLocker="/repos/github/docker"
export dirBuildResults="/BuildResults"

new_step "mkdir -p ${dirBuildResults}"
          mkdir -p ${dirBuildResults}

new_step "yum update -y | tee    ${dirBuildResults}/yum-update.txt"
    echo "yum update -y | tee    ${dirBuildResults}/yum-update.txt" > ${dirBuildResults}/yum-update.txt
          yum update -y | tee -a ${dirBuildResults}/yum-update.txt

new_step "yum upgrade -y | tee    ${dirBuildResults}/yum-upgrade.txt"
    echo "yum upgrade -y | tee    ${dirBuildResults}/yum-upgrade.txt" > ${dirBuildResults}/yum-upgrade.txt
          yum upgrade -y | tee -a ${dirBuildResults}/yum-upgrade.txt

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
new_step 'yum group install "Development Tools" -y | tee    ${dirBuildResults}/development-tools.txt'
    echo "yum group install "Development Tools" -y | tee    ${dirBuildResults}/development-tools.txt" > ${dirBuildResults}/development-tools.txt
          yum group install "Development Tools" -y | tee -a ${dirBuildResults}/development-tools.txt

echo "trying to install ${#tpls_apt[@]} packages..."
for t in ${tpls_apt[@]}; do
    new_step "yum install ${t} -y | tee    ${dirBuildResults}/install-${t}.txt 2>&1"
        echo "yum install ${t} -y | tee    ${dirBuildResults}/install-${t}.txt 2>&1" > ${dirBuildResults}/install-${t}.txt
              yum install ${t} -y | tee -a ${dirBuildResults}/install-${t}.txt 2>&1
done

# builds are complete: survey results
new_step "yum list available >  ${dirBuildResults}/list-available.txt"
    echo "yum list available >  ${dirBuildResults}/list-available.txt" > ${dirBuildResults}/list-available.txt
          yum list available >> ${dirBuildResults}/list-available.txt

new_step "yum list installed >  ${dirBuildResults}/list-installed.txt"
    echo "yum list installed >  ${dirBuildResults}/list-installed.txt" > ${dirBuildResults}/list-installed.txt
          yum list installed >> ${dirBuildResults}/list-installed.txt

new_step "yum list kernel    >  ${dirBuildResults}/list-kernel.txt"
    echo "yum list kernel    >  ${dirBuildResults}/list-kernel.txt"   > ${dirBuildResults}/list-repo.txt
          yum list kernel    >> ${dirBuildResults}/list-kernel.txt

echo 'source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}'
      source ${dirDockerLocker}/unified/generics/generic-kickstart.sh ${mySpack} ${refresh}
