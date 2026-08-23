#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# ptyxis.sh

pt()
{
    local key="$1"
    local mode="${2:-tab}"

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
        Wolfram)
            title="Wolfram"
            path="wolfram"
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
            echo "usage: pt {builds|framework|github|jop|wolfram|f} [w]"
            return 1
            ;;
    esac

    if [[ "$mode" == "w" ]]; then
        ptyxis \
            --new-window \
            --title="$title" \
            --working-directory="$HOME/repos-$(hostname)/github/$path"
    else
        ptyxis \
            --tab \
            --title="$title" \
            --working-directory="$HOME/repos-$(hostname)/github/$path"
    fi
}

