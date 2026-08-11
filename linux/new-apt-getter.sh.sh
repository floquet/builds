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

machine=$(hostname -s)

results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"
package_dir="${APT_PACKAGE_DIR:-${HOME}/repos/github/builds/packages}"

install_dir="${results_dir}/install"

# ----------------------------------------------------------------------
# Initialize
# ----------------------------------------------------------------------

new_step "Initialize apt-getter"

sub_step "machine = ${machine}"
sub_step "results_dir = ${results_dir}"
sub_step "package_dir = ${package_dir}"

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

    apt-get install "${package}" -y \
        >> "${output_file}" 2>&1

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

new_step "Locate package manifests"

manifest_count=0

for package_file in "${package_dir}"/*.txt; do

    if [[ ! -f "${package_file}" ]]; then
        continue
    fi

    manifest_count=$((manifest_count + 1))

    echo "  $(basename "${package_file}")"
done

if [[ ${manifest_count} -eq 0 ]]; then
    echo ""
    echo "ERROR: no package manifests found in:"
    echo "  ${package_dir}"
    exit 1
fi

for package_file in "${package_dir}"/*.txt; do
    [[ -f "${package_file}" ]] || continue

    install_package_file "${package_file}"
done

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