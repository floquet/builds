#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Jul 31 19:24:48 UTC 2020

# start the timer
export mySECONDS=0
# timestamp results
export ymd=$(date +%Y-%m-%d-%H-%M)
export timerFile="${dirDockerLocker}/unified/timers/${platform}-${machine}-${owner}-${dist}-${release}-tpls.txt";

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export   gcc_default=${1}
export python_default="python@3.8.5"

# export  tpls_spack=(openmpi@4.0.4 openmpi@3.1.6 armadillo cassandra chapel cmake environment-modules flang libgeotiff gdb julia moab mysql opencoarrays openspeedshop paraview petsc postgresql sqlite tau trilinos valgrind visit vtk zoltan gdl)
export  tpls_spack=(openmpi@4.0.5 openmpi@3.1.6 chapel cmake environment-modules flang gdb julia opencoarrays paraview petsc tau trilinos valgrind zoltan)
export  tpls_python_spack=(chapel cmake environment-modules flang gdb julia opencoarrays paraview petsc tau trilinos valgrind zoltan)

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

# enter spack directory to prepare for builds
new_step 'export this_arch="arch=$(spack arch)"'
          export this_arch="arch=$(spack arch)"

for t in ${tpls_spack}; do
    export logFile="${dirBuildLog}/gcc@${c}.log";
    date                 >  ${logFile}
    echo ""              >> ${logFile}
    echo "${SPACK_ROOT}" >> ${logFile}
    echo ""              >> ${logFile}
    cat /etc/os-release  >> ${logFile}
    echo ""              >> ${logFile}
    tick=SECONDS
    new_step "spack install ${t} % ${gcc_default} ${this_arch}"
              spack install ${t} % ${gcc_default} ${this_arch}
done

new_step "time used for third party libraries = ${mySECONDS} s"
date                 >  "${timerFile}"
echo ""              >> "${timerFile}"
echo "${SPACK_ROOT}" >> "${timerFile}"
echo ""              >> "${timerFile}"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
printf 'time for other tpls: %dh:%dm:%ds\n' $(($mySECONDS/3600)) $(($mySECONDS%3600/60)) $(($mySECONDS%60))  >> "${timerFile}"

date
