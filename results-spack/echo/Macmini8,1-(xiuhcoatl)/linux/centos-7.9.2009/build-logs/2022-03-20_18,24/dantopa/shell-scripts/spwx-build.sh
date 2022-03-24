#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# source ${repo_scripts_spack}/environment/build-environment.sh

export SpWxSECONDS=${SECONDS}

source ${repo_scripts_spack}/shared/common-header.sh

export dirInfo="${SPACK_ROOT}/${USER}/info"
export dirInstall="${SPACK_ROOT}/${USER}/build-logs"
export dirSpec="${SPACK_ROOT}/${USER}/specs"
export timerfile="${dirInstall}/spwx-build-time.txt"

declare -a lpackages=("py-tqdm" "py-urllib3" "py-seaborn" "py-astropy+extras" )

new_step "\${myCompiler}=${myCompiler}"
new_step "\${myPython}=${myPython}"

pause

new_step "Try to build ${#lpackages[@]} packages: ${lpackages[@]}"
sub_step_counter=0
for t in ${lpackages[@]}; do
    sub_step "install ${t}"
    spack info ${t} 2>&1 > ${dirInfo}/${t}.txt &
    spack spec ${t} 2>&1 > ${dirSpec}/${t}.txt &
    date >> ${dirInstall}/${t}.txt
    echo "spack install ${t} ${myCompiler} ${myPython} 2>&1 | tee -a ${dirInstall}/${t}.txt" >> ${dirInstall}/${t}.txt
          spack install ${t} ${myCompiler} ${myPython} 2>&1 | tee -a ${dirInstall}/${t}.txt
done

new_step "Report elapsed time"
    export SpWxSECONDS=$((${SECONDS}-${SpWxSECONDS}))
    date    >  ${timerFile}
    echo "" >> ${timerFile}
    printf 'time to build ubuntu system: %dh:%dm:%ds\n' $((${SpWxSECONDS}/3600)) $((${SpWxSECONDS}%3600/60)) $((${SpWxSECONDS}%60)) | tee -a ${timerFile}

new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"

