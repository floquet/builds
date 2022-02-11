#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

export elapsed=${SECONDS}

export python="^python@3.10.2"
export  numpy="^py-numpy@1.22.2"
export  setup="^py-setuptools@59.4.0"
export pandas="^py-pandas@1.4.0"
export  scipy="^py-scipy@1.8.0"
export    pip="^py-pip@21.3.1"

export andsoon=" % gcc@11.2.0 ${python} ${numpy} ${setup} ${pandas} ${scipy} ${pip}"

# spack install py-seaborn ${andsoon} > ${USER}/build-logs/py-seaborn.txt
# spack info py-seaborn              > ${USER}/info/py-seaborn.txt
# spack spec py-seaborn % gcc@11.2.0 > ${USER}/specs/py-seaborn.txt
spack install gcc@11.2.0                                    > ${SPACK_ROOT}/${USER}/build-logs/gcc@11.2.0.txt
spack compiler find $(spack location -i gcc@11.2.0)
spack load gcc@11.2.0

spack install py-seaborn        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-seaborn.txt
spack install py-beautifulsoup4 % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-beautifulsoup4
spack install py-virtualenv     % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-virtualenv
spack install py-urllib3        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-urllib3
spack install py-tqdm           % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-tqdm
spack install py-pip            % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-pip
spack install py-urllib3        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/build-logs/py-urllib3


spack spec gcc@11.2.0                                    > ${SPACK_ROOT}/${USER}/specs/gcc@11.2.0.txt
spack spec py-seaborn        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-seaborn.txt
spack spec py-beautifulsoup4 % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-beautifulsoup4
spack spec py-virtualenv     % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-virtualenv
spack spec py-urllib3        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-urllib3
spack spec py-tqdm           % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-tqdm
spack spec py-pip            % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-pip
spack spec py-urllib3        % gcc@11.2.0 ^python@3.10.1 > ${SPACK_ROOT}/${USER}/specs/py-urllib3
