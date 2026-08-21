#!/usr/bin/env bash

# config-git-wsl.sh
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

new_step "Configure User Identity"
    sub_step "Set user name: git config --global user.name \"Daniel Topa\""
        git config --global user.name "Daniel Topa"
    sub_step "Set user email: git config --global user.email daniel.topa@baesystems.us"
        git config --global user.email "daniel.topa@baesystems.us"

new_step "Configure Editor and Diff Tools"
    sub_step "Set editor to vim: git config --global core.editor \"vim\""
        git config --global core.editor "vim"
    sub_step "Set diff tool to vimdiff: git config --global diff.tool vimdiff"
        git config --global diff.tool vimdiff
    sub_step "Set merge tool to vimdiff: git config --global merge.tool vimdiff"
        git config --global merge.tool vimdiff

elapsed=$((${SECONDS} - ${start_time}))

printf '\nelapsed time: %dh:%dm:%ds\n' \
    $((${elapsed} / 3600)) \
    $((${elapsed} % 3600 / 60)) \
    $((${elapsed} % 60))
