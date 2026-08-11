#! /usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

#Initialize counters
counter=0
subcounter=0
start_time=${SECONDS}
machine=$(hostname -s)

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

    results_dir="${APT_RESULTS_DIR:-${HOME}/.info/${machine}/apt}"

    sub_step "machine=$(hostname -s)"
              machine=$(hostname -s)
    sub_step "mkdir -p  ${results_dir}"
              mkdir -p "${results_dir}"

    sub_step "Feedback"
        echo "begin time:            $(date)"
        echo "machine name:          ${machine}"
        echo "results sub directory: ${results_dir}"
        echo ""

new_step "git --version"
          git --version
new_step "git lfs version"
          git lfs version
new_step "git --version"
          git --version
new_step "git lfs version"
          git lfs version
new_step "git config --global --list"
          git config --global --list
new_step "ssh -V"
          ssh -V
new_step "ssh-keygen -lf ~/.ssh/id_ed25519_${machine}.pub"
          ssh-keygen -lf ~/.ssh/id_ed25519_${machine}.pub
new_step "git config --system --list"
          git config --system --list

elapsed=$((SECONDS - start_time))

printf "time to inspect apt distribution: %dh:%dm:%ds\n" \
    $((elapsed / 3600)) \
    $((elapsed % 3600 / 60)) \
    $((elapsed % 60))

echo ""
echo "end: $(date)"
