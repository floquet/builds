#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"


: "${pInfo:?pInfo is not set}"

dest="$pInfo/arXive"
mkdir -p "$dest"

cp -- "$HOME/.vimrc"         "$dest/"
cp -- "$HOME/.gitconfig.sh"  "$dest/"
cp -- "$HOME/.$(hostname).sh "$dest/"

