#!/usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

counter=0
subcounter=0
start_time=${SECONDS}

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
# Settings
# ----------------------------------------------------------------------

new_step "Settings"

machine=$(hostname -s)

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
package_dir="${script_dir}/packages"
results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"
install_dir="${results_dir}/install"

sub_step "machine = ${machine}"
sub_step "package_dir = ${package_dir}"
sub_step "results_dir = ${results_dir}"

mkdir -p "${install_dir}"

# ----------------------------------------------------------------------
# Package manifests
#
# One line = one packages/*.txt file
# ----------------------------------------------------------------------

package_files=(
    tools-basic.txt
    tools-network.txt
    tools-git.txt
    compilers.txt
    compiler-libraries.txt
    coarrays.txt
    math-libs.txt
    math-libs-hpc.txt
    python.txt
    tex.txt
    tool.txt
)

# ----------------------------------------------------------------------
# apt update
# ----------------------------------------------------------------------

new_step "apt-get update"

output_file="${results_dir}/results-update.txt"

{
    date
    echo
    echo "sudo apt-get update"
    echo
} > "${output_file}"

sudo apt-get update 2>&1 |
    tee -a "${output_file}"

# ----------------------------------------------------------------------
# apt upgrade
# ----------------------------------------------------------------------

new_step "apt-get upgrade -y"

output_file="${results_dir}/results-upgrade.txt"

{
    date
    echo
    echo "sudo apt-get upgrade -y"
    echo
} > "${output_file}"

sudo apt-get upgrade -y 2>&1 |
    tee -a "${output_file}"

# ----------------------------------------------------------------------
# Install one manifest
# ----------------------------------------------------------------------

install_manifest()
{
    local manifest="$1"
    local package_file="${package_dir}/${manifest}"
    local package_group="${manifest%.txt}"
    local output_file="${install_dir}/${package_group}.txt"

    local packages=()

    new_step "Install package group: ${package_group}"

    if [[ ! -f "${package_file}" ]]; then
        echo "ERROR: package manifest not found:"
        echo "  ${package_file}"
        return 1
    fi

    while IFS= read -r package || [[ -n "${package}" ]]; do

        # Strip leading/trailing whitespace
        package="${package#"${package%%[![:space:]]*}"}"
        package="${package%"${package##*[![:space:]]}"}"

        # Ignore blank lines
        [[ -z "${package}" ]] && continue

        # Ignore comments
        [[ "${package}" == \#* ]] && continue

        packages+=("${package}")

    done < "${package_file}"

    sub_step "${#packages[@]} packages"

    if [[ ${#packages[@]} -eq 0 ]]; then
        echo "  no packages found"
        return 0
    fi

    {
        date
        echo
        echo "package group: ${package_group}"
        echo
        printf 'sudo apt-get install -y'
        printf ' %q' "${packages[@]}"
        echo
        echo
    } > "${output_file}"

    sudo apt-get install -y "${packages[@]}" \
        2>&1 | tee -a "${output_file}"

    rc=${PIPESTATUS[0]}

    printf "%s\t%d\t%d\n" \
        "${package_group}" \
        "${#packages[@]}" \
        "${rc}" \
        >> "${results_dir}/install-status.tsv"

    if [[ ${rc} -eq 0 ]]; then
        echo "  installed: ${package_group}"
    else
        echo "  FAILED: ${package_group}  rc=${rc}"
    fi
}

# ----------------------------------------------------------------------
# Initialize installation status
# ----------------------------------------------------------------------

{
    echo "# apt-genesis installation status"
    echo "# $(date)"
    echo "# machine: ${machine}"
    echo
    printf "group\tpackage_count\treturn_code\n"
} > "${results_dir}/install-status.tsv"

# ----------------------------------------------------------------------
# Install manifests
# ----------------------------------------------------------------------

new_step "Install package manifests"

for manifest in "${package_files[@]}"; do
    install_manifest "${manifest}"
done

# ----------------------------------------------------------------------
# Autoremove
# ----------------------------------------------------------------------

new_step "apt-get autoremove -y"

output_file="${results_dir}/results-autoremove.txt"

{
    date
    echo
    echo "sudo apt-get autoremove -y"
    echo
} > "${output_file}"

sudo apt-get autoremove -y 2>&1 |
    tee -a "${output_file}"

# ----------------------------------------------------------------------
# Summary
# ----------------------------------------------------------------------

new_step "Show output"

echo "results posted to:"
echo "  ${results_dir}/results-update.txt"
echo "  ${results_dir}/results-upgrade.txt"
echo "  ${results_dir}/results-autoremove.txt"
echo "  ${results_dir}/install-status.tsv"
echo
echo "installation transcripts:"
echo "  ${install_dir}"

echo
echo "failures:"

awk -F '\t' '
    /^[#]/ { next }

    $3 != 0 && $3 != "return_code" {
        printf "  %-24s packages=%-4s rc=%s\n", $1, $2, $3
        found = 1
    }

    END {
        if (!found)
            print "  none"
    }
' "${results_dir}/install-status.tsv"

elapsed=$((SECONDS - start_time))

echo
printf 'elapsed time: %dh:%dm:%ds\n' \
    $((elapsed / 3600)) \
    $((elapsed % 3600 / 60)) \
    $((elapsed % 60))

echo
echo "end: $(date)"
