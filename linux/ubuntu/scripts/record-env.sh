#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

date > "${pSelf}/alias.txt"
echo "env" >> "${pSelf}/env.txt"
env >> "${pSelf}/env.txt"
