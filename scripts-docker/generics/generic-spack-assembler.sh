#! /bin/#!
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Mon Nov  1 12:18:11 MDT 2021

# initialize spack - or -
# navigate to spack directory
# add a compiler if you don't want the default
#  . /repos/github/docker/unified/generics/generic-spack-assembler.sh

# add spack
# mirrors:
#    external-drive: file:///spacktivity/mirror/
# modify system compiler to match gcc -v name (e.g. gcc@8.5.0-4)
export         SECONDS=0
export              ymd=$(date +%Y-%m-%d-%H-%M) # timestamp results
export              yo="${owner}-${os}-${release}"
export     dirTimerLog="${dirDockerLocker}/unified/timers/${os}/${release}/";
export     dirBuildLog="${dirDockerLocker}/build-logs/${os}/${release}/";

mkdir -p ${dirTimerLog}
mkdir -p ${dirBuildLog}

export       timerFile="${dirBuildLog}/${yo}-generic-spack-assembler.txt";
export         tplFile="${dirBuildLog}/${yo}-tpls.txt";
export   compilersFile="${dirBuildLog}/${yo}-compilers.txt";
export      configFile="${dirBuildLog}/${yo}-configuration.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

if [ $# -eq 0 ]
    then
        export default_compiler=${gcc_system_compiler}
    else
        export default_compiler=${1}
fi

new_step "Using compiler ${default_compiler}"

if [ -z "$dirDockerLocker" ]
    then
        export dirDockerLocker=${ddocker}
fi
new_step "dirDockerLocker=${dirDockerLocker}"

export dirBuildLog="${dirDockerLocker}/unified/build-logs/${os}/${release}/${default_compiler}"
mkdir -p ${dirBuildLog}

new_step "Build logs directory=${dirBuildLog}"

source ${dirDockerLocker}/generics/generic-file-header.sh ${tplFile}
source ${dirDockerLocker}/generics/generic-file-header.sh ${compilersFile}
source ${dirDockerLocker}/generics/generic-file-header.sh ${configFile}

new_step "source ${dirDockerLocker}/unified/spack/compilers-gcc.sh  ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/compilers-gcc.sh  ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/pythons.sh        ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/pythons.sh        ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/compilers-llvm.sh ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/compilers-llvm.sh ${default_compiler}

new_step "source ${dirDockerLocker}/unified/spack/tpls.sh           ${default_compiler}"
          source ${dirDockerLocker}/unified/spack/tpls.sh           ${default_compiler}

new_step "total time used"
date    >  "${timerFile}"
echo "" >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds
printf 'time for all build suites: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))  >> "${timerFile}"
printf 'time for all build suites: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

new_step "feed_spack_mirror"
          feed_spack_mirror

date
