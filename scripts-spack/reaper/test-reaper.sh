#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Fri Dec  3 12:31:35 MST 2021

# requires spack initiation:
# source test-reaper.zsh

# source ${repo_build}/scripts-spack/reaper/test-reaper.sh

source ${repo_build}/scripts-spack/reaper/header-reaper.sh

export reapSECONDS=${SECONDS}

new_step "Mark initial directory"
    export dirStart="$(pwd)"

new_step "Define directory structure"
#    export repoTarget="${repos}/github/astra-spack-mirror"
#    export  dirTarget="${repoTarget}/${HOST}/${USER}/$(basename ${SPACK_ROOT})"
    export  spack_tag=$(basename $(pwd))
    export       arch=$(spack arch)
    export repoTarget="${repo_build}/results-spack/"
    #export  dirTarget="${dir_spack}/${platform}/${machine}/${moniker}/${drive}/${owner}/${spack_tag}/${dist}/${release}"
    # ${vrepos}/github/build/darwin-monterey-skylake/${machine}/${moniker}/${os}/${dist}/${release}
    #export  dirTarget="${repoTarget}/${arch}/${spack_tag}/${dir_config}"
    export  dirTarget="${repoTarget}/echo/${dir_config}/${spack_tag}/${ymdt}"

    export           dirYamls="${dirTarget}/yamls"
    #export        dirDotSpack="${dirTarget}/dotspack"
    export        dirInstalls="${dirTarget}/installs"
    export       dirCompilers="${dirTarget}/compilers"
    export  dirConfigurations="${dirTarget}/configurations"

    echo           "${dirYamls} = \${dirYamls}"
    #echo        "${dirDotSpack} = \${dirDotSpack}"
    echo        "${dirInstalls} = \${dirInstalls}"
    echo       "${dirCompilers} = \${dirCompilers}"
    echo  "${dirConfigurations} = \${dirConfigurations}"

if [ ! -z "$1" ]
  then
    echo "No argument supplied: only check directory structure"
    exit 1
fi

pause

new_step "mkdir directory structure"
    mkdir -p ${dirYamls}
    #mkdir -p ${dirDotSpack}
    mkdir -p ${dirInstalls}
    mkdir -p ${dirCompilers}
    mkdir -p ${dirConfigurations}

new_step "Define configuration properties"
    declare -a lConfig=("config" "compilers" "packages" "mirrors" "modules" "repos")
    echo "\${lConfig} = ${lConfig}"

new_step "compilers"
    myFile="${dirCompilers}/spack-compilers.txt"
    file_header "${myFile}"
    echo "spack compilers" >> ${myFile}
          spack compilers  >> ${myFile}

new_step "installs"
    myFile="${dirInstalls}/spack-find.txt"
    file_header "${myFile}"
    echo "spack find" >> ${myFile}
          spack find  >> ${myFile}

    myFile="${dirInstalls}/spack-find-ldf.txt"
    file_header "${myFile}"
    echo "spack find --long --deps --show-full-compiler" >> ${myFile}
          spack find --long --deps --show-full-compiler  >> ${myFile}

new_step "sweeping ${#lOptions[@]} options for spack find..."
export lOptions=("explicit" "implicit" "json" "missing" "namespace" "only-missing" "paths" "variants" "unknown" "very-long")
export clicker=0
for o in ${lOptions[@]}; do
    #sub_step "spack find ${o}..."
    myFile="${dirInstalls}/spack-find-${o}.txt"
    file_header "${myFile}"
    sub_step "spack find --${o} >> ${myFile}"
              spack find --${o} >> ${myFile}
done

    myFile="${dirInstalls}/spack-bootstrap-find.txt"
    file_header "${myFile}"
    sub_step "spack --bootstrap find >> ${myFile}"
              spack --bootstrap find >> ${myFile}


new_step "Sweep ${#lConfig[@]} configuration properties with get"
export clicker=0
for c in ${lConfig[@]}; do
    #sub_step "working on get ${c}..."
    myFile="${dirConfigurations}/spack-config-get-${c}.txt"
    file_header "${myFile}"
    sub_step "spack config get ${c} >> ${myFile}"
              spack config get ${c} >> ${myFile}
done

new_step "Sweep ${#lConfig[@]} configuration properties with blame"
export clicker=0
for c in ${lConfig[@]}; do
    myFile="${dirConfigurations}/spack-config-blame-${c}.txt"
    file_header "${myFile}"
    sub_step "spack config blame ${c} >> ${myFile}"
              spack config blame ${c} >> ${myFile}
done

export read_dir="topa"
if [ -d "${SPACK_ROOT}/${read_dir}" ]; then
    export  write_dir="${dirTarget}/${read_dir}"; mkdir -p ${write_dir}; echo "\${write_dir} = ${write_dir}"
    new_step "copy ${read_dir} files"
        echo "rsync -vauh ${SPACK_ROOT}/${read_dir}/. ${dirTopa}/.  "
              rsync -vauh ${SPACK_ROOT}/${read_dir}/. ${dirTopa}/.
fi

export test_dir="dantopa"
if [ -d "${SPACK_ROOT}/${test_dir}" ]; then
    export  dirTopa="${dirTarget}/${test_dir}"; mkdir -p ${dirTopa}; echo "\${dirTopa} = ${dirTopa}"
    new_step "copy ${test_dir} files"
        echo "rsync -vauh ${SPACK_ROOT}/${test_dir}/. ${dirTopa}/."
              rsync -vauh ${SPACK_ROOT}/${test_dir}/. ${dirTopa}/.
fi

# new_step "copy .spack *.yaml files"
#     echo "rsync -vauh ~/.spack ${dirDotSpack}"
#           rsync -vauh ~/.spack ${dirDotSpack}

new_step "copy .spack *.yaml files"

    cd ~/.spack
    mkdir -p ${dirYamls}/.spack
    echo "find . -name '*.yaml' | cpio -pdm  ${dirYamls}/.spack > ${repoTarget}/yaml-sweep-dot-spack.txt"
          find . -name '*.yaml' | cpio -pdm  ${dirYamls}/.spack > ${repoTarget}/yaml-sweep-dot-spack.txt

    cd ${SPACK_ROOT}
    # https://unix.stackexchange.com/questions/83593/copy-specific-file-type-keeping-the-folder-structure
    echo "find . -name '*.yaml' | cpio -pdm  ${dirYamls} > ${repoTarget}/yaml-sweep-spack-root.txt"
          find . -name '*.yaml' | cpio -pdm  ${dirYamls} > ${repoTarget}/yaml-sweep-spack-root.txt
    # echo 'rsync -zarv --prune-empty-dirs --include "*/" --include="*compilers.yaml" --include="*config.yaml" --include="*mirrors.yaml" --include="*modules.yaml" --include="*packages.yaml" --include="*repos.yaml" --exclude="*" "${SPACK_ROOT}/." "${gdirTarget}/yamls"'
    #       rsync -zarv --prune-empty-dirs --include "*/" --include="*compilers.yaml" --include="*config.yaml" --include="*mirrors.yaml" --include="*modules.yaml" --include="*packages.yaml" --include="*repos.yaml" --exclude="*" "${SPACK_ROOT}/." "${gdirTarget}/yamls"

new_step "Add and commit to spack logger"
    cd ${repoTarget}
    # git add -A .
    # git commit -m "${ymd} ${spack_tag}"
    # git clean -d -f -x
    echo "repo at \${repoTarget} = ${repoTarget}"

new_step "return home: cd ${dirStart}"
                       cd ${dirStart}

new_step "print wall time used"
    export reapSECONDS=$((${SECONDS}-${reapSECONDS}))
    printf 'time for all builds: %dh:%dm:%ds\n' $(($reapSECONDS/3600)) $(($reapSECONDS%3600/60)) $(($reapSECONDS%60))

new_step "script completed at $(date)"
