#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Capture Bash shell options
{
    date

    echo
    echo "COMMAND: set -o"
    set -o

    echo
    echo "COMMAND: shopt -p"
    shopt -p

    echo
    echo "COMMAND: umask -p"
    umask -p

    echo
    echo "COMMAND: ulimit -a"
    ulimit -a
} > "${pSelf}/shell-options.txt"

