#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

echo "\${SHELL} = ${SHELL}"

# remove training wheels
# alias cp="cp"
# alias mv="mv"
# alias rm="rm"

export LSCOLORS=exfxcxdxbxegedabagacad
