#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Require pInfo to be set and non-empty; otherwise print the error and terminate.
: "${pInfo:?pInfo is not set}"

dest="$pInfo/arXive"
mkdir -p "$dest"

cp -- "$HOME/.${HOSTNAME}.sh" "$dest/"
cp -- "$HOME/.vimrc"          "$dest/"
cp -- "$HOME/.gitconfig"      "$dest/"
