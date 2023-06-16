#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Mon Nov  1 12:34:06 MDT 2021

# start the timer
export mySECONDS=$SECONDS
# timestamp results
export          ymd=$(date +%Y-%m-%d-%H-%M)
export dirTimerFile="${dirTimerLog}/unified/timers/${owner}/${dist}/${release}";
export    timerFile="${dirTimerFile}/tpls-gcc.txt";

mkdir -p ${dirTimerFile}

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

export   gcc_default=${1}
export python_default="python@3.9.7"

export  tpls_spack="openmpi@4.1.5 openmpi@3.1.6 armadillo cassandra chapel cmake cpio environment-modules eigen3 fftw flang libgeotiff moab mpich mysql opencoarrays openspeedshop postgresql sqlite strumpack valgrind visit vtk zoltan"
# export  tpls_spack="openmpi@4.0.4 openmpi@3.1.6 chapel cmake environment-modules flang gdb julia mpich opencoarrays paraview petsc tau trilinos valgrind zoltan"

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

new_step "spack compiler find"
          spack compiler find

# enter spack directory to prepare for builds
export this_arch="arch=$(spack arch)"
new_step "\${this_arch} = ${this_arch}"

for t in ${tpls_spack}; do
    export logFile="${dirBuildLog}/${t}.log";
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${logfile}
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${timerFile}

    tick=SECONDS
    new_step "spack install ${t} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1"
              spack install ${t} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1
    let time="SECONDS-tick"
    printf '\ntime for ${t} compiler: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
done

new_step "time used for third party libraries = ${mySECONDS} s"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
let time="SECONDS-mySECONDS"
printf 'time for all tpls: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
printf 'time for all tpls: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60))

date
