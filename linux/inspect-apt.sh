#! /usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

#Initialize counters
counter=0
subcounter=0
start_time=${SECONDS}

# counts steps in batch process
counter=0
function new_step(){
    counter=$((counter+1))
    subcounter=0
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step() {
    subcounter=$((subcounter + 1))
    echo ""
    echo "  Substep ${counter}.${subcounter}: ${1}"
}

new_step "Settings"

    machine=$(hostname -s)
    results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"

    sub_step "mkdir -p ${results_dir}"
              mkdir -p "${results_dir}"

    sub_step "Feedback"
        echo "begin time:            $(date)"
        echo "machine name:          ${machine}"
        echo "results sub directory: ${results_dir}"
        echo ""

# ----------------------------------------------------------------------
# Operating system
# ----------------------------------------------------------------------

new_step "Catalog operating system"

{
    date
    echo
    echo 'cat /etc/os-release'
          cat /etc/os-release
} > "${results_dir}/os-release.txt"


# ----------------------------------------------------------------------
# Kernel
# ----------------------------------------------------------------------

new_step "Catalog kernel"

{
    date
    echo
    echo 'uname -a'
          uname -a
} > "${results_dir}/kernel.txt"


# ----------------------------------------------------------------------
# Package architecture
# ----------------------------------------------------------------------

new_step "Catalog package architecture"

{
    date
    echo

    echo 'dpkg --print-architecture'
          dpkg --print-architecture

    echo
    echo 'dpkg --print-foreign-architectures'
          dpkg --print-foreign-architectures
} > "${results_dir}/architecture.txt"


# ----------------------------------------------------------------------
# Installed packages
# ----------------------------------------------------------------------

new_step "Catalog installed packages"

{
    date
    echo

    echo "dpkg-query -W -f='\${binary:Package}\t\${Version}\t\${Architecture}\n'"

    dpkg-query -W \
        -f='${binary:Package}\t${Version}\t${Architecture}\n'

} > "${results_dir}/installed.txt"


# ----------------------------------------------------------------------
# APT sources
# ----------------------------------------------------------------------

new_step "Catalog APT sources"

sources_dir="${results_dir}/sources"

rm   -rf "${sources_dir}"
mkdir -p "${sources_dir}/sources.list.d"

{
    date
    echo

    if [[ -f /etc/apt/sources.list ]]; then

        echo 'cp /etc/apt/sources.list "${sources_dir}/sources.list"'

        cp /etc/apt/sources.list \
            "${sources_dir}/sources.list"

        echo "copied: /etc/apt/sources.list"

    else

        echo "/etc/apt/sources.list does not exist"

    fi

    echo

    if [[ -d /etc/apt/sources.list.d ]]; then

        echo 'cp -a /etc/apt/sources.list.d/. "${sources_dir}/sources.list.d/"'

        cp -a /etc/apt/sources.list.d/. \
            "${sources_dir}/sources.list.d/"

        echo "copied: /etc/apt/sources.list.d/"

    else

        echo "/etc/apt/sources.list.d does not exist"

    fi

    echo
    echo "APT source configuration copied verbatim to:"
    echo "${sources_dir}"

} > "${results_dir}/sources.txt"


# ----------------------------------------------------------------------
# Held packages
# ----------------------------------------------------------------------

new_step "Catalog held packages"

{
    date
    echo
    echo 'apt-mark showhold'
          apt-mark showhold
} > "${results_dir}/held.txt"


# ----------------------------------------------------------------------
# Upgradable packages
# ----------------------------------------------------------------------

new_step "Catalog upgradable packages"

{
    date
    echo
    echo 'apt list --upgradable 2>/dev/null'
          apt list --upgradable 2>/dev/null
} > "${results_dir}/upgradable.txt"

# ----------------------------------------------------------------------
# Manually installed packages
# ----------------------------------------------------------------------

new_step "Catalog manually installed packages"

{
    date
    echo
    echo 'apt-mark showmanual'
          apt-mark showmanual
} > "${results_dir}/manual.txt"

# ----------------------------------------------------------------------
# APT cache
# ----------------------------------------------------------------------

new_step "Catalog APT cache"

{
    date
    echo
    echo 'apt-cache stats'
          apt-cache stats
} > "${results_dir}/cache-stats.txt"

# ----------------------------------------------------------------------
# Summary
# ----------------------------------------------------------------------

new_step "Summary"

echo ""
echo "results posted to:"
echo "  ${results_dir}"
echo ""

echo "files:"
find "${results_dir}" -type f -print | sort

echo ""

elapsed=$((SECONDS - start_time))

printf "time to inspect apt distribution: %dh:%dm:%ds\n" \
    $((elapsed / 3600)) \
    $((elapsed % 3600 / 60)) \
    $((elapsed % 60))

echo ""
echo "end: $(date)"
