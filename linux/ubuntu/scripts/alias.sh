#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

alias lss='ls -alh'

# source/reload
alias sr='echo "source ${HOME}/.${HOSTNAME}.sh"; source "${HOME}/.${HOSTNAME}.sh"'


