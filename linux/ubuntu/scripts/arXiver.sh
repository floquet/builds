#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

mkdir -p $pInfo/arXive

cp ~/.${HOSTNAME}.sh ${pInfo}/arXive/.
cp ~/.vimrc          ${pInfo}/arXive/.
cp ~/.gitconfig.sh   ${pInfo}/arXive/.


