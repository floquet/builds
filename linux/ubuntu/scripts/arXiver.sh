#!/usr/bin/env bash


printf '%s, %s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$(basename "${BASH_SOURCE[0]}")"

: "${pInfo:?pInfo is not set}"

dest="$pInfo/arXive"
mkdir -p "$dest"

set -euo pipefailcp -- "$HOME/.vimrc"         "$dest/"
cp -- "$HOME/.gitconfig.sh"  "$dest/"
