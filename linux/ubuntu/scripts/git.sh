#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

function commit-builds() {
    local message="${1:-Update Ubuntu configuration: $HOSTNAME}"

    pushd "${pBuilds}" > /dev/null || return 1

    # git status
    # git diff --stat
    git config pull.rebase false
    git add linux/ubuntu
    # git diff --cached
    git commit -m "${message}"

    popd > /dev/null
}


