#!/usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Initialize counters

counter=0
subcounter=0
start_time=${SECONDS}

# Count steps in batch process

function new_step() {
    counter=$((counter + 1))
    subcounter=0
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step() {
    subcounter=$((subcounter + 1))
    echo ""
    echo "  Substep ${counter}.${subcounter}: ${1}"
}

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------


new_step "Initialize names"

machine=$(hostname -s)

# results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"
# package_dir="${APT_PACKAGE_DIR:-${HOME}/repos/github/builds/packages}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
package_dir="${APT_PACKAGE_DIR:-${script_dir}/packages}"

install_dir="${results_dir}/install"

    sub_step "machine     = ${machine}"
    sub_step "script_dir  = ${script_dir}"
    sub_step "package_dir = ${package_dir}"
    sub_step "install_dir = ${install_dir}"

# ----------------------------------------------------------------------
# Initialize
# ----------------------------------------------------------------------

new_step "Check package_dir"

mkdir -p "${install_dir}"

if [[ ! -d "${package_dir}" ]]; then
    echo ""
    echo "ERROR: package directory does not exist:"
    echo "  ${package_dir}"
    exit 1
fi

# ----------------------------------------------------------------------
# Install one package
# ----------------------------------------------------------------------

install_package()
{
    package="$1"
    package_group="$2"

    output_file="${install_dir}/${package}.txt"

    sub_step "Install ${package}"

    {
        date
        echo
        echo "package group: ${package_group}"
        echo "apt-get install ${package} -y"
        echo
    } > "${output_file}"

    sudo apt-get install "${package}" -y >> "${output_file}" 2>&1

    rc=$?

    printf "%s\t%s\t%d\n" \
        "${package_group}" \
        "${package}" \
        "${rc}" \
        >> "${results_dir}/install-status.tsv"

    if [[ ${rc} -eq 0 ]]; then
        echo "    installed: ${package}"
    else
        echo "    FAILED:    ${package}  rc=${rc}"
    fi
}

# ----------------------------------------------------------------------
# Install one package manifest
# ----------------------------------------------------------------------

install_package_file()
{
    package_file="$1"
    package_group=$(basename "${package_file}" .txt)

    new_step "Install package group: ${package_group}"

    while IFS= read -r package || [[ -n "${package}" ]]; do

        # Ignore blank lines
        [[ -z "${package}" ]] && continue

        # Ignore comments
        [[ "${package}" =~ ^[[:space:]]*# ]] && continue

        install_package "${package}" "${package_group}"

    done < "${package_file}"
}

# ----------------------------------------------------------------------
# Initialize status report
# ----------------------------------------------------------------------

{
    echo "# apt-getter installation status"
    echo "# $(date)"
    echo "# machine: ${machine}"
    echo
    printf "group\tpackage\treturn_code\n"
} > "${results_dir}/install-status.tsv"

# ----------------------------------------------------------------------
# Process package manifests
# ----------------------------------------------------------------------

if [[ $# -ne 1 ]]; then
    echo ""
    echo "Usage: $0 manifest.txt"
    exit 1
fi

package_file="${package_dir}/$1"

if [[ ! -f "${package_file}" ]]; then
    echo ""
    echo "ERROR: package manifest does not exist:"
    echo "  ${package_file}"
    exit 1
fi

new_step "Install selected package manifest"

    sub_step "$(basename "${package_file}")"

    install_package_file "${package_file}"

# ----------------------------------------------------------------------
# Summary
# ----------------------------------------------------------------------

new_step "Summarize installation"

echo ""
echo "installation status:"
echo "  ${results_dir}/install-status.tsv"

echo ""
echo "installation transcripts:"
echo "  ${install_dir}"

echo ""
echo "failures:"

awk -F '\t' '
    BEGIN { found = 0 }
    /^[#]/ { next }
    $3 != 0 && $3 != "return_code" {
        printf "  %-20s %-30s rc=%s\n", $1, $2, $3
        found = 1
    }
    END {
        if (found == 0)
            print "  none"
    }
' "${results_dir}/install-status.tsv"

elapsed=$((SECONDS - start_time))

echo ""

printf "time to install apt packages: %dh:%dm:%ds\n" \
    $((elapsed / 3600)) \
    $((elapsed % 3600 / 60)) \
    $((elapsed % 60))

echo ""
echo "end: $(date)"