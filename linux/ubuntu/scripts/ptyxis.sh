#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

pt()
{
    local key="$1"

    case "$key" in
        builds)
            title="Builds"
            path="builds"
            ;;
        framework)
            title="Framework"
            path="framework"
            ;;
        github)
            title="GitHub"
            path="."
            ;;
        jop)
            title="JOP"
            path="jop"
            ;;
        f|fortran)
            title="Fortran"
            path="f"
            ;;
        *)
            echo "usage: pt {builds|framework|github|jop|f}"
            return 1
            ;;
    esac

    ptyxis \
        --new-window \
        --title="$title" \
        --working-directory="$HOME/repos-$(hostname)/github/$path"
}
