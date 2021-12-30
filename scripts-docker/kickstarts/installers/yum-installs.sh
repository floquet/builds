#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# source yum-installs.sh ${lpackages} ${dirBuildResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "yum update -v -y | tee ${2}/update.txt 2>&1"
          yum update -v -y | tee ${2}/update.txt 2>&1

sub_step "yum upgrade -v -y | tee ${2}/update.txt 2>&1"
          yum upgrade -v -y | tee ${2}/update.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step 'yum group install -v "Development Tools" -y | tee ${2}/update 2>&1'
          yum group install -v "Development Tools" -y | tee ${2}/update 2>&1

new_step "Try to build ${#1[@]} packages"
sub_step_counter=0
for t in ${1[@]}; do
    sub_step "yum install -v ${t} -y | tee ${2}/install-${t}.txt 2>&1"
              yum install -v ${t} -y | tee ${2}/install-${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "yum list available > ${2}/list-available.txt"
          yum list available > ${2}/list-available.txt

sub_step "yum list installed > ${2}/list-installed.txt"
          yum list installed > ${2}/list-installed.txt

sub_step "yum list kernel    > ${2}/list-kernel.txt"
          yum list kernel    > ${2}/list-kernel.txt
