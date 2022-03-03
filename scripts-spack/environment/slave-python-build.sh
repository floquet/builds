#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# called from ${repo_scripts_spack}/environment/master-spack.sh

export python=${SECONDS}

spack load ${myCompiler}

date

spack info ${myCompiler}      > ${dirInfo}/${myCompiler}.txt &
spack info py-astropy         > ${dirInfo}/py-astropy.txt    &
spack info py-seaborn         > ${dirInfo}/py-seaborn.txt    &
spack info py-beautifulsoup4  > ${dirInfo}/py-beautifulsoup4 &
spack info py-virtualenv      > ${dirInfo}/py-virtualenv     &
spack info py-urllib3         > ${dirInfo}/py-urllib3        &
spack info py-tqdm            > ${dirInfo}/py-tqdm           &
spack info py-pip             > ${dirInfo}/py-pip            &
spack info py-urllib3         > ${dirInfo}/py-urllib3        &
spack info git-lfs            > ${dirInfo}/git-lfs.txt       &

date

spack spec ${myCompiler}                               > ${dirSpecs}/${myCompiler}.txt &
spack spec cfitsio           ${myCompiler} ${myPython} > ${dirSpecs}/cfitsio.txt       &
spack spec py-astropy        ${myCompiler} ${myPython} > ${dirSpecs}/py-astropy.txt    &
spack spec py-seaborn        ${myCompiler} ${myPython} > ${dirSpecs}/py-seaborn.txt    &
spack spec py-beautifulsoup4 ${myCompiler} ${myPython} > ${dirSpecs}/py-beautifulsoup4 &
spack spec py-virtualenv     ${myCompiler} ${myPython} > ${dirSpecs}/py-virtualenv     &
spack spec py-urllib3        ${myCompiler} ${myPython} > ${dirSpecs}/py-urllib3        &
spack spec py-tqdm           ${myCompiler} ${myPython} > ${dirSpecs}/py-tqdm           &
spack spec py-pip            ${myCompiler} ${myPython} > ${dirSpecs}/py-pip            &
spack spec py-urllib3        ${myCompiler} ${myPython} > ${dirSpecs}/py-urllib3        &
spack spec git-lfs           ${myCompiler} ${myPython} > ${dirSpecs}/git-lfs.txt       &

date

spack install git-lfs           ${myCompiler} ${myPython} | tee ${dirInstall}/git-lfs.txt       2>&1
spack install cfitsio@3.49      ${myCompiler}             | tee ${dirInstall}/cfitsio.txt 2>&1
spack install py-astropy        ${myCompiler} ${myPython}  ^cfitsio/xlvzqi | tee ${dirInstall}/py-astropy.txt 
spack install py-astropy        ${myCompiler} ${myPython} | tee ${dirInstall}/py-astropy.txt    2>&1
spack install py-seaborn        ${myCompiler} ${myPython} | tee ${dirInstall}/py-seaborn.txt    2>&1
spack install py-beautifulsoup4 ${myCompiler} ${myPython} | tee ${dirInstall}/py-beautifulsoup4 2>&1
spack install py-virtualenv     ${myCompiler} ${myPython} | tee ${dirInstall}/py-virtualenv     2>&1
spack install py-urllib3        ${myCompiler} ${myPython} | tee ${dirInstall}/py-urllib3        2>&1
spack install py-tqdm           ${myCompiler} ${myPython} | tee ${dirInstall}/py-tqdm           2>&1
spack install py-pip            ${myCompiler} ${myPython} | tee ${dirInstall}/py-pip            2>&1
spack install py-urllib3        ${myCompiler} ${myPython} | tee ${dirInstall}/py-urllib3        2>&1

date

export python=$((${SECONDS}-${python}))
printf 'time for python builds: %dh:%dm:%ds\n' $((${python}/3600)) $((${python}%3600/60)) $((${python}%60))
