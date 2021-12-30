#! /bin/sh
printf '%s\n' "$(date) ${BASH_SOURCE[0]}"

# Wed Dec 29 19:05:24 MST 2021

# https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf

# source yum-installs.sh
# pass as globals: ${lpackages} ${dirBuildResults}
#  1: array of package names
#  2: directory to post results

new_step "Update, upgrade, install Development Tools"
sub_step_counter=0
sub_step "yum update -v -y | tee ${dirBuildResults}/update.txt 2>&1"
    echo "yum update -v -y" >    ${dirBuildResults}/update.txt 2>&1
          yum update -v -y  >>   ${dirBuildResults}/update.txt 2>&1

sub_step "yum upgrade -v -y | tee ${dirBuildResults}/upgrade.txt 2>&1"
    echo "yum upgrade -v -y" >    ${dirBuildResults}/upgrade.txt 2>&1
          yum upgrade -v -y  >>   ${dirBuildResults}/upgrade.txt 2>&1

# https://linuxize.com/post/how-to-install-gcc-on-centos-8/
sub_step 'yum group install -v "Development Tools" -y | tee ${dirBuildResults}/dev-tools.txt 2>&1'
          yum group install -v "Development Tools" -y | tee ${dirBuildResults}/dev-tools.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step_counter=$((sub_step_counter+1))
    sub_sub_step_counter=0
    sub_sub_step "yum install -v ${t} -y  | tee -a ${dirBuildResults}/install-${t}.txt    2>&1"
            echo "yum install -v ${t} -y" >        ${dirBuildResults}/install-${t}.txt    2>&1
                  yum install -v ${t} -y  | tee -a ${dirBuildResults}/install-${t}.txt    2>&1

    sub_sub_step "yum info    -v ${t}  >           ${dirBuildResults}/info-${t}.txt       2>&1"
            echo "yum info    -v ${t}" >           ${dirBuildResults}/info-${t}.txt       2>&1
                  yum info    -v ${t} -y  >>       ${dirBuildResults}/info-${t}.txt       2>&1

    sub_sub_step "yum deplist -v ${t}  >           ${dirBuildResults}/dependents-${t}.txt 2>&1"
            echo "yum deplist -v ${t}" >           ${dirBuildResults}/dependents-${t}.txt 2>&1
                  yum deplist -v ${t}     >>       ${dirBuildResults}/dependents-${t}.txt 2>&1
done

new_step "Prepare summary reports"
sub_step_counter=0

sub_step "yum list available > ${dirBuildResults}/list-available.txt"
          yum list available > ${dirBuildResults}/list-available.txt

sub_step "yum list installed > ${dirBuildResults}/list-installed.txt"
          yum list installed > ${dirBuildResults}/list-installed.txt

sub_step "yum list kernel    > ${dirBuildResults}/list-kernel.txt"
          yum list kernel    > ${dirBuildResults}/list-kernel.txt
