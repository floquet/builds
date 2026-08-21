#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

alias lss='ls -alh'i
alias wolf="/usr/local/Wolfram/Wolfram/15.0/Executables/Wolfram"
alias nb="/usr/local/Wolfram/Wolfram/15.0/Executables/WolframNB"

# source/reload
alias sr='echo "source ${HOME}/.${HOSTNAME}.sh"; source "${HOME}/.${HOSTNAME}.sh"'


