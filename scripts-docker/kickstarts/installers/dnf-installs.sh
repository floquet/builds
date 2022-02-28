#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 18:36:57 MST 2021

# source dnf-installer.sh ${lpackages} ${localResults}
#  1: array of package names
#  2: directory to post results
new_step "Create directory structure"

    export local_Results="/yum_results"
    sub_step "\${local_Results} = ${local_Results}"

    sub_step "mkdir -p ${local_Results}/info"
              mkdir -p ${local_Results}/info

    sub_step "mkdir -p ${local_Results}/install"
              mkdir -p ${local_Results}/install

    sub_step "mkdir -p ${local_Results}/dependents"
              mkdir -p ${local_Results}/dependents

pause 
new_step "Update, upgrade, install Development Tools"
    sub_step_counter=0
    sub_step "dnf update -v -y | tee -a ${localResults}/update.txt 2>&1"
              dnf update -v -y | tee -a ${localResults}/update.txt 2>&1

    sub_step "dnf upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1"
              dnf upgrade -v -y | tee -a ${localResults}/upgrade.txt 2>&1

    # https://linuxize.com/post/how-to-install-gcc-on-centos-8/
    sub_step 'dnf group install -v "Development Tools" -y | tee ${localResults}/dev-tools.txt 2>&1'
              dnf group install -v "Development Tools" -y | tee ${localResults}/dev-tools.txt 2>&1

new_step "Try to build ${#lpackages[@]} packages"
    sub_step_counter=0
    for t in ${lpackages[@]}; do
        sub_step "dnf install -v ${t} -y | tee -a ${localResults}/install-${t}.txt 2>&1"
                  dnf install -v ${t} -y | tee -a ${localResults}/install-${t}.txt 2>&1

        sub_step "dnf info ${t} | tee -a ${localResults}/info/${t}.txt 2>&1"
                  dnf info ${t} | tee -a ${localResults}/info/${t}.txt.txt &

        sub_step "dnf repoquery --requires ${t} | tee -a ${localResults}/dependents/${t}.txt 2>&1"
                  dnf repoquery --requires ${t} | tee -a ${localResults}/dependents/${t}.txt &
    done

new_step "Prepare summary reports"
    sub_step_counter=0
    sub_step "dnf list available > ${localResults}/list-available.txt"
              dnf list available > ${localResults}/list-available.txt &

    sub_step "dnf list installed > ${localResults}/list-installed.txt"
              dnf list installed > ${localResults}/list-installed.txt &

    sub_step "dnf list repo      > ${localResults}/list-repo.txt"
              dnf list repo      > ${localResults}/list-repo.txt      &
