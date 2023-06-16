#! /bin/bash
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"
# Mon Nov  1 12:18:11 MDT 2021

# start the timer
export mySECONDS=$SECONDS
# timestamp results
export             ymd=$(date +%Y-%m-%d-%H-%M)
export dirTimerFile="${dirTimerLog}/unified/timers/${owner}/${dist}/${release}";
export    timerFile="${dirTimerFile}/python.txt";

mkdir -p ${dirTimerFile}

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

#export   gcc_default="gcc@10.1.1"  # fedora
export    gcc_default=${1}  # xiuhcoatl
export python_default="3.10.10"
export python_verions="${python_default} 3.11.2 2.7.18"
export    python_tpls="py-seaborn py-tqdm py-beautifulsoup4 py-urllib3 py-astropy py-bokeh py-geoplot py-leather py-jupyter py-sympy py-scientificpython py-xlsxwriter blitz gdb gdl julia  petsc rust tau trilinos paraview gdl"
# export    python_tpls="py-jupyter py-numpy py-pandas py-sympy py-scipy py-scientificpython py-xlsxwriter"

# activate spack
new_step "source share/spack/setup-env.sh"
          source share/spack/setup-env.sh

# enter spack directory to prepare for builds
export this_arch="arch=$(spack arch)"
new_step "\${this_arch} = ${this_arch}"

for p in ${python_verions}; do
    export logFile="${dirBuildLog}/python@${c}.log";
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${logfile}
    source ${dirDockerLocker}/unified/generics/generic-file-header.sh ${timerFile}

    tick=SECONDS
    new_step "spack install python@${p} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1"
              spack install python@${p} % ${gcc_default} ${this_arch} >> ${logFile} 2>&1
done

for t in ${python_tpls}; do
    new_step "spack install ${t} % ${gcc_default} ^python@${python_default} ${this_arch} 2>&1"
              spack install ${t} % ${gcc_default} ^python@${python_default} ${this_arch} 2>&1
    let time="SECONDS-tick"
    printf '\ntime for "python@${t}"" compiler: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
done

new_step "time used for python installs = ${mySECONDS} s"
# https://stackoverflow.com/questions/12199631/convert-mySECONDS-to-hours-minutes-mySECONDS
let time="SECONDS-mySECONDS"
printf 'time for all pythons: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60)) >> "${timerFile}"
printf 'time for all pythons: %dh %dm %ds\n' $((time/3600)) $((time%3600/60)) $((time%60))

date
