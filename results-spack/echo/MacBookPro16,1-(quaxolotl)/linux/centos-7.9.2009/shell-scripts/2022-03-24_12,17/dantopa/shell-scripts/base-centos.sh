#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export master=${SECONDS}

echo "spack install py-astropy+extras ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-astropy.txt" >> py-astropy.txt
spack install py-astropy+extras ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-astropy.txt

echo "spack install py-tqdm ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-tqdm.txt" >> py-tqdm.txt
spack install py-tqdm ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-tqdm.txt

echo "spack install py-urllib3 ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-urllib3.txt" >> py-urllib3.txt
spack install py-urllib3 ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-urllib3.txt

echo "spack install py-virtualenv ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-virtualenv.txt" >> py-virtualenv.txt
spack install py-virtualenv ${myCompiler} ${myPython}  2>&1 | tee -a ${mySpackLogs}/py-virtualenv.txt

    export master=$((${SECONDS}-${master}))
    printf 'time for all builds: %dh:%dm:%ds\n' $((${master}/3600)) $((${master}%3600/60)) $((${master}%60))
