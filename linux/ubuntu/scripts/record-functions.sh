#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Bash functions
# -F: catalog
# -f: definitions
{
    date

    echo
    echo "COMMAND: declare -F"
    declare -F

    echo
    echo "COMMAND: declare -f"
    declare -f
} > "${pSelf}/functions.txt"

