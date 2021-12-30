#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 18:36:57 MST 2021

# source dnf-installer.sh ${lpackages} ${dirBuildResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "dnf update -v -y | tee -a ${2}/update.txt 2>&1"
          dnf update -v -y | tee -a ${2}/update.txt 2>&1

sub_step "dnf upgrade -v -y | tee -a ${2}/update.txt 2>&1"
          dnf upgrade -v -y | tee -a ${2}/update.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step 'dnf group install -v "Development Tools" -y | tee ${2}/update 2>&1'
          dnf group install -v "Development Tools" -y | tee ${2}/update 2>&1

new_step "Try to build ${#1[@]} packages"
sub_step_counter=0
for t in ${1[@]}; do
    sub_step "dnf install -v ${t} -y | tee -a ${2}/install-${t}.txt 2>&1"
              dnf install -v ${t} -y | tee -a ${2}/install-${t}.txt 2>&1

              dnf info ${t}  > ${2}/info-${t}.txt &
done

new_step "Prepare summary reports"
sub_step_counter=0
sub_step "dnf list available > ${2}/list-available.txt"
          dnf list available > ${2}/list-available.txt &

sub_step "dnf list installed > ${2}/list-installed.txt"
          dnf list installed > ${2}/list-installed.txt &

sub_step "dnf list repo      > ${2}/list-repo.txt"
          dnf list repo      > ${2}/list-repo.txt      &
