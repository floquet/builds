#! /usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

start_time=${SECONDS}

machine=$(hostname -s)
results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"

mkdir -p "${results_dir}"

echo "begin:   $(date)"
echo "machine: ${machine}"
echo "results: ${results_dir}"
echo ""


# ----------------------------------------------------------------------
# Operating system
# ----------------------------------------------------------------------

echo "Step 1 of 7: operating system"

{
    date
    echo
    echo 'cat /etc/os-release'
    cat /etc/os-release
} > "${results_dir}/os-release.txt"


# ----------------------------------------------------------------------
# Kernel
# ----------------------------------------------------------------------

echo "Step 2 of 7: kernel"

{
    date
    echo
    echo 'uname -a'
    uname -a
} > "${results_dir}/kernel.txt"


# ----------------------------------------------------------------------
# Package architecture
# ----------------------------------------------------------------------

echo "Step 3 of 7: package architecture"

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

echo "Step 4 of 7: installed packages"

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

echo "Step 5 of 7: APT sources"

sources_dir="${results_dir}/sources"

rm -rf "${sources_dir}"
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

echo "Step 6 of 7: held packages"

{
    date
    echo
    echo 'apt-mark showhold'
    apt-mark showhold
} > "${results_dir}/held.txt"


# ----------------------------------------------------------------------
# Upgradable packages
# ----------------------------------------------------------------------

echo "Step 7 of 7: upgradable packages"

{
    date
    echo
    echo 'apt list --upgradable 2>/dev/null'
    apt list --upgradable 2>/dev/null
} > "${results_dir}/upgradable.txt"


# ----------------------------------------------------------------------
# Summary
# ----------------------------------------------------------------------

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
