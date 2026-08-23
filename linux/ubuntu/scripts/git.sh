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

function config_git(){
    echo "Setting Git configurations for Daniel Topa..."

    # Identity
    git config --global user.name "Daniel Topa"
    git config --global user.email "dantopa@gmail.com"

    # Branch behavior
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    git config --global push.default simple
    git config --global push.autoSetupRemote true

    # Interface
    git config --global color.ui auto
    git config --global core.editor vim
    git config --global core.pager "less -FRX"

    # Merge behavior
    git config --global merge.tool meld
    git config --global rerere.enabled true

    echo "Git configuration for Daniel Topa is complete."
}


