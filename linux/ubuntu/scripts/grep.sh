#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

function g-tex() {
    echo "grep -inr --include='*.tex' \"$1\" ."
    grep -inr --include='*.tex' "$1" .
}

function g-fortran() {
    echo "grep -inr --include='*.f08' \"$1\" ."
    grep -inr --include='*.f08' "$1" .
}

function g-general() {
    echo "grep -inr --include='*.f*' \"$1\" ."
    grep -inr --include='*.f*' "$1" .
}

function g-newcommand() {
    local pattern="$1"

    if [[ -z "$pattern" ]]; then
        echo "Usage: g-newcommand <command_name>"
        return 1
    fi

    echo "grep -Einr --include='*.tex' '\\(new|renew|provide)command\{[[:space:]]*\\\\${pattern}' ."

    grep -Einr \
        --include='*.tex' \
        "\\\\(new|renew|provide)command\{[[:space:]]*\\\\${pattern}" .
}

