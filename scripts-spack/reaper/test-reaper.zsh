#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${BASH_SOURCE[0]}$(tput sgr0)"
# Fri Dec  3 12:31:35 MST 2021

# requires spack initiation:
# source modern-reaper.zsh

source ${repo_build}/scripts-spack/reaper/header-reaper.zsh

new_step "Mark initial directory"
    export dirStart="$(pwd)"

new_step "Define directory structure"
#    export repoTarget="${repos}/github/astra-spack-mirror"
#    export  dirTarget="${repoTarget}/${HOST}/${USER}/$(basename ${SPACK_ROOT})"
    export  spack_tag=$(echo "${SPACK_ROOT}" | sed 's:/:-:g' | cut -c 2-)
    export       arch=$(spack arch)
    export repoTarget="${repo_build}/results-spack/"
    #export  dirTarget="${dir_spack}/${platform}/${machine}/${moniker}/${drive}/${owner}/${spack_tag}/${dist}/${release}"
    # ${vrepos}/github/build/darwin-monterey-skylake/${machine}/${moniker}/${os}/${dist}/${release}
    #export  dirTarget="${repoTarget}/${arch}/${spack_tag}/${dir_config}"
    export  dirTarget="${repoTarget}/${arch}/${dir_config}"

    export           dirYamls="${dirTarget}/yamls"
    export        dirDotSpack="${dirTarget}/dotspack"
    export        dirInstalls="${dirTarget}/installs"
    export       dirCompilers="${dirTarget}/compilers"
    export  dirConfigurations="${dirTarget}/configurations"

    echo           "${dirYamls} = \${dirYamls}"
    echo        "${dirDotSpack} = \${dirDotSpack}"
    echo        "${dirInstalls} = \${dirInstalls}"
    echo       "${dirCompilers} = \${dirCompilers}"
    echo  "${dirConfigurations} = \${dirConfigurations}"

if [ ! -z "$1" ]
  then
    echo "No argument supplied: only check directory structure"
    exit 1
fi

new_step "mkdir directory structure"
    mkdir -p ${dirYamls}
    mkdir -p ${dirDotSpack}
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
export lOptions=("bootstrap" "explicit" "implicit" "json" "missing" "namespace" "only-missing" "paths" "variants" "unknown" "very-long")
export clicker=0
for o in ${lOptions[@]}; do
    #sub_step "spack find ${o}..."
    myFile="${dirInstalls}/spack-find-${o}.txt"
    file_header "${myFile}"
    sub_step "spack find --${o} >> ${myFile}"
              spack find --${o} >> ${myFile}
done

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
    file_header "${my File}"
    sub_step "spack config blame ${c} >> ${myFile}"
              spack config blame ${c} >> ${myFile}
done

export test_dir="${SPACK_ROOT}/topa"
if [ -d "${test_dir}" ]; then
    export  dirTopa="${test_dir}"; mkdir -p ${dirTopa}; echo "${dirTopa} = \${dirTopa}"
    new_step "copy ${test_dir} files"
        echo "rsync -vauh ${test_dir} ${dirTopa}"
              rsync -vauh ${test_dir} ${dirTopa}
fi

export test_dir="${SPACK_ROOT}/dantopa"
if [ -d "${test_dir}" ]; then
    export  dirTopa="${test_dir}"; mkdir -p ${dirTopa}; echo "${dirTopa} = \${dirTopa}"
    new_step "copy ${test_dir} files"
        echo "rsync -vauh ${test_dir} ${dirTopa}"
              rsync -vauh ${test_dir} ${dirTopa}
fi

# new_step "copy .spack *.yaml files"
#     echo "rsync -vauh ~/.spack ${dirDotSpack}"
#           rsync -vauh ~/.spack ${dirDotSpack}

new_step "copy .spack *.yaml files"

    cd ~/.spack
    mkdir -p ${dirYamls}/.spack
    echo "find . -name '*.yaml' | cpio -pdm  ${dirYamls}/.spack"
          find . -name '*.yaml' | cpio -pdm  ${dirYamls}/.spack

    cd ${SPACK_ROOT}
    # https://unix.stackexchange.com/questions/83593/copy-specific-file-type-keeping-the-folder-structure
    echo "find . -name '*.yaml' | cpio -pdm  ${dirYamls}"
          find . -name '*.yaml' | cpio -pdm  ${dirYamls}
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
    printf 'time for all builds: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

new_step "script completed at $(date)"
