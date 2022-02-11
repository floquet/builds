#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# $ source /repos/github/builds/scripts-spack/python/quick-python.sh

export elapsed=SECONDS

mkdir -p ${SPACK_ROOT}/${USER}/build-logs
mkdir -p ${SPACK_ROOT}/${USER}/specs
mkdir -p ${SPACK_ROOT}/${USER}/info
mkdir -p ${SPACK_ROOT}/${USER}/shell-scripts

# spack install gcc@11.2.0                                    > ${SPACK_ROOT}/${USER}/build-logs/gcc@11.2.0.txt
# spack compiler find $(spack location -i gcc@11.2.0)

myPython="python@3.10.2"
myCompiler="gcc@11.2.0-16ubuntu1"
# spack load ${myCompiler}

date

spack info ${myCompiler}      > ${SPACK_ROOT}/${USER}/info/${myCompiler}.txt &
spack info py-astropy         > ${SPACK_ROOT}/${USER}/info/py-astropy.txt    &
spack info py-seaborn         > ${SPACK_ROOT}/${USER}/info/py-seaborn.txt    &
spack info py-beautifulsoup4  > ${SPACK_ROOT}/${USER}/info/py-beautifulsoup4 &
spack info py-virtualenv      > ${SPACK_ROOT}/${USER}/info/py-virtualenv     &
spack info py-urllib3         > ${SPACK_ROOT}/${USER}/info/py-urllib3        &
spack info py-tqdm            > ${SPACK_ROOT}/${USER}/info/py-tqdm           &
spack info py-pip             > ${SPACK_ROOT}/${USER}/info/py-pip            &
spack info py-urllib3         > ${SPACK_ROOT}/${USER}/info/py-urllib3        &
spack info git-lfs            > ${SPACK_ROOT}/${USER}/info/git-lfs.txt       &

date

spack spec ${myCompiler}                                  > ${SPACK_ROOT}/${USER}/specs/${myCompiler}.txt &
spack spec py-astropy        % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-astropy.txt    &
spack spec py-seaborn        % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-seaborn.txt    &
spack spec py-beautifulsoup4 % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-beautifulsoup4 &
spack spec py-virtualenv     % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-virtualenv     &
spack spec py-urllib3        % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-urllib3        &
spack spec py-tqdm           % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-tqdm           &
spack spec py-pip            % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-pip            &
spack spec py-urllib3        % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/py-urllib3        &
spack spec git-lfs           % ${myCompiler} ^${myPython} > ${SPACK_ROOT}/${USER}/specs/git-lfs.txt       &

date

spack install git-lfs           % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/git-lfs.txt       2>&1
spack install py-astropy        % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-astropy.txt    2>&1
spack install py-seaborn        % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-seaborn.txt    2>&1
spack install py-beautifulsoup4 % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-beautifulsoup4 2>&1
spack install py-virtualenv     % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-virtualenv     2>&1
spack install py-urllib3        % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-urllib3        2>&1
spack install py-tqdm           % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-tqdm           2>&1
spack install py-pip            % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-pip            2>&1
spack install py-urllib3        % ${myCompiler} ^${myPython} | tee ${SPACK_ROOT}/${USER}/build-logs/py-urllib3        2>&1

date

new_step "print wall time used"
    export elapsed=$((${SECONDS}-${elapsed}))
    printf 'time for all builds: %dh:%dm:%ds\n' $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60))
