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

new_step "Settings"
      sub_step "machine=$(hostname -s)"
                machine=$(hostname -s)
      sub_step results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"
               results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"

new_step "mkdir -p ${results_dir}"
          mkdir -p "${results_dir}"

new_step "apt-get update"

date > "${results_dir}/results-update.txt"
echo "apt-get update 2>&1 | tee -a ${results_dir}/results-update.txt" \
    >> "${results_dir}/results-update.txt"

apt-get update 2>&1 |
    tee -a "${results_dir}/results-update.txt"

new_step "apt-get upgrade -y"

date > "${results_dir}/results-upgrade.txt"
echo "apt-get upgrade -y 2>&1 | tee -a ${results_dir}/results-upgrade.txt" \
    >> "${results_dir}/results-upgrade.txt"

apt-get upgrade -y 2>&1 |
    tee -a "${results_dir}/results-upgrade.txt"

new_step "apt-get autoremove"

date > "${results_dir}/results-autoremove.txt"
echo "apt-get update 2>&1 | tee -a ${results_dir}/results-remove.txt" \
    >> "${results_dir}/results-autoremove.txt"

new_step "Show output"
echo "results posted to:"
echo "  ${results_dir}/results-update.txt"
echo "  ${results_dir}/results-upgrade.txt"
echo "  ${results_dir}/results-autoremove.txt"
echo ""

echo "end: $(date)"

elapsed=$((${SECONDS} - ${start_time}))

printf 'elapsed time: %dh:%dm:%ds\n' \
    $((${elapsed} / 3600)) \
    $((${elapsed} % 3600 / 60)) \
    $((${elapsed} % 60))
