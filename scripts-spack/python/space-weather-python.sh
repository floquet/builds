#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export elapsed=${SECONDS}

export myCompiler=" % gcc@11.2.0"
export myPython=" ^python@3.10.2"
export    numpy=" ^py-numpy@1.22.2"
export    setup=" ^py-setuptools@59.4.0"
export   pandas=" ^py-pandas@1.4.0"
export    scipy=" ^py-scipy@1.8.0"
export      pip=" ^py-pip@21.3.1"

export dirSpec="${SPACK_ROOT}/${USER}/specs"
export dirLogs="${SPACK_ROOT}/${USER}/build-logs"
export dirInfo="${SPACK_ROOT}/${USER}/info"

export andsoon=" ${myCompiler} ${python} ${numpy} ${setup} ${pandas} ${scipy} ${pip}"

# spack install py-seaborn ${andsoon} > ${USER}/build-logs/py-seaborn.txt
# spack info py-seaborn              > ${USER}/info/py-seaborn.txt
# spack spec py-seaborn ${myCompiler} > ${USER}/specs/py-seaborn.txt
spack install gcc@11.2.0 | tee ${dirLogs}/gcc@11.2.0.txt 2>&1
spack compiler find $(spack location -i gcc@11.2.0)
spack load gcc@11.2.0

spack info gcc@11.2.0        ${dirInfo}/gcc@11.2.0.txt  2>&1 &
spack info cfitsio           ${dirInfo}/cfitsio.txt 2>&1
spack info py-astropy        ${dirInfo}/py-astropy.txt  2>&1 &
spack info py-seaborn        ${dirInfo}/py-seaborn.txt  2>&1 &
spack info py-beautifulsoup4 ${dirInfo}/py-beautifulsoup4.txt  2>&1 &
spack info py-virtualenv     ${dirInfo}/py-virtualenv.txt 2>&1 &
spack info py-urllib3        ${dirInfo}/py-urllib3.txt  2>&1 &
spack info py-tqdm           ${dirInfo}/py-tqdm.txt  2>&1 &
spack info py-pip            ${dirInfo}/py-pip.txt  2>&1 &
spack info py-urllib3        ${dirInfo}/py-urllib3.txt  2>&1 &
spack info llvm              ${dirInfo}/llvm.txt  2>&1 &

spack spec gcc@11.2.0                      ${dirSpecs}/gcc@11.2.0.txt  2>&1 &
spack spec cfitsio           ${myCompiler} ${myPython} /cfitsio.txt  2>&1 &
spack spec py-astropy        ${myCompiler} ${myPython} /py-astropy.txt  2>&1 &
spack spec py-seaborn        ${myCompiler} ${myPython} /py-seaborn.txt  2>&1 &
spack spec py-beautifulsoup4 ${myCompiler} ${myPython} /py-beautifulsoup4.txt  2>&1 &
spack spec py-virtualenv     ${myCompiler} ${myPython} /py-virtualenv.txt  2>&1 &
spack spec py-urllib3        ${myCompiler} ${myPython} /py-urllib3.txt  2>&1 &
spack spec py-tqdm           ${myCompiler} ${myPython} /py-tqdm.txt  2>&1 &
spack spec py-pip            ${myCompiler} ${myPython} /py-pip.txt  2>&1 &
spack spec py-urllib3        ${myCompiler} ${myPython} /py-urllib3.txt  2>&1 &

spack install cfitsio@3.49      ${myCompiler}             | tee ${mySpackLogs}/cfitsio.txt 2>&1
spack install py-astropy        ${myCompiler} ${myPython} ^cfitsio/xlvzqi | tee ${dirLogs}/py-astropy.txt 2>&1
spack install py-seaborn        ${myCompiler} ${myPython} | tee ${dirLogs}/py-seaborn.txt 2>&1
#spack install py-beautifulsoup4 ${myCompiler} ${myPython} | tee ${dirLogs}/py-beautifulsoup4
spack install py-virtualenv     ${myCompiler} ${myPython} | tee ${dirLogs}/py-virtualenv 2>&1
spack install py-urllib3        ${myCompiler} ${myPython} | tee ${dirLogs}/py-urllib3 2>&1
spack install py-tqdm           ${myCompiler} ${myPython} | tee ${dirLogs}/py-tqdm 2>&1
spack install py-pip            ${myCompiler} ${myPython} | tee ${dirLogs}/py-pip 2>&1
spack install py-urllib3        ${myCompiler} ${myPython} | tee ${dirLogs}/py-urllib3 2>&1

new_step "print elapsed time used"
    export elapsed=$((${SECONDS}-${elapsed}))
    printf 'time for spack to build python packages: %dh:%dm:%ds\n' $((${elapsed}/3600)) $((${elapsed}%3600/60)) $((${elapsed}%60))


new_step "$(tput bold)${BASH_SOURCE[0]}$(tput sgr0) script completed at $(date)"
