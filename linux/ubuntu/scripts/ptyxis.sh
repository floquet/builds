#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# ptyxis.sh

pt()
{
    local key="$1"
    local mode="${2:-tab}"

    local title
    local path
    local command=""

    case "$key" in

        builds)
            title="Builds"
            path="$HOME/repos-$(hostname)/github/builds"
            ;;

        framework)
            title="Framework"
            path="$HOME/repos-$(hostname)/gitlab/framework"
            ;;

        github)
            title="GitHub"
            path="$HOME/repos-$(hostname)/github"
            ;;

        gitlab)
            title="GitLab"
            path="$HOME/repos-$(hostname)/gitlab"
            ;;

        wolfram|Wolfram)
            title="Wolfram"
            path="$HOME"
            command="wolfram"
            ;;

        jop)
            title="JOP"
            path="$HOME/repos-$(hostname)/github/jop"
            ;;

        f|fortran)
            title="Fortran"
            path="$HOME/repos-$(hostname)/github/f"
            ;;

        *)
            echo "usage: pt {builds|framework|github|gitlab|jop|wolfram|f} [w]"
            return 1
            ;;

    esac

    if [[ ! -d "$path" ]]; then
        echo "pt: directory does not exist: $path"
        return 1
    fi

    if [[ "$mode" == "w" ]]; then

        if [[ -n "$command" ]]; then
            ptyxis \
                --new-window \
                --title="$title" \
                --working-directory="$path" \
                -- bash -ic "$command"
        else
            ptyxis \
                --new-window \
                --title="$title" \
                --working-directory="$path"
        fi

    else

        if [[ -n "$command" ]]; then
            ptyxis \
                --tab \
                --title="$title" \
                --working-directory="$path" \
                -- bash -ic "$command"
        else
            ptyxis \
                --tab \
                --title="$title" \
                --working-directory="$path"
        fi

    fi
}
