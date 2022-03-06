#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export totalSECONDS=${SECONDS}

export vault="${volume_ext}/docker-land"

export timerFile=${vault}/${ymdtf}/tar-times.txt
    date    >  ${timerFile}
    echo "" >> ${timerFile}

# source /repos/github/builds/scripts-docker/bash-inits/paths.sh
source ${repo_scripts_spack}/shared/common-header.sh

# docker image save spwx-02-amzn:2022 > spwx-02-amzn-2022.
function arXiver(){
    localSECONDS=${SECONDS}
    echo ""
    echo "docker save ${1}:${2} > ${vault}/${1}-${2}.tar.gz"
          docker save ${1}:${2} > ${vault}/${1}-${2}.tar.gz 2>&1 | tee -a ${timerfile}
    localSECONDS=$((${SECONDS}-${localSECONDS}))
    printf 'time to archive ${1}:${2}: %dh:%dm:%ds\n' $((${totalSECONDS}/3600)) $((${totalSECONDS}%3600/60)) $((${totalSECONDS}%60)) | tee -a ${timerfile}
    }

export tag="${centos_version}"
new_step "\${tag} = ${tag}"
    sub_step_counter=0

    export image="spwx-03-centos"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-02-centos"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-01-centos"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

export tag="2022"
new_step "\${tag} = ${tag}"
    sub_step_counter=0

    export image="spwx-02-amzn"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-01-amzn"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

export tag="bookworm"
new_step "\${tag} = ${tag}"
    sub_step_counter=0

    export image="spwx-debian-03"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-debian-02"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-debian-01"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

export tag="35"
new_step "\${tag} = ${tag}"
    sub_step_counter=0

    export image="spwx-02-fedora"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

    export image="spwx-01-fedora"
    sub_step "\${image} = ${image}"
    arXiver ${image} ${tag}

export tag="${ubuntu_version}"
export image="science-ubuntu"
new_step "\${image}:\${tag} = ${image}:${tag}"
    arXiver ${image} ${tag}


export totalSECONDS=$((${SECONDS}-${totalSECONDS}))
    printf 'time archive all images: %dh:%dm:%ds\n' $((${totalSECONDS}/3600)) $((${totalSECONDS}%3600/60)) $((${totalSECONDS}%60)) | tee -a ${timerFile}
    
# docker load < /Volumes/Tlaloc/docker-land/spwx-02-amzn-2022.tar 
