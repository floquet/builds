#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

localTime=$SECONDS
recorderStart=$SECONDS

# locate files relative to master.sh
pHere="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "${pHere}/alias.sh"
source "${pHere}/arXiver.sh"
source "${pHere}/fortran.sh"
source "${pHere}/fortran-stack.sh"
source "${pHere}/git.sh"
source "${pHere}/go.sh"
source "${pHere}/grep.sh"
source "${pHere}/vim.sh"
source "${pHere}/recorder.sh"

if [[ -n "${TERMINAL_TITLE:-}" ]]; then
    PROMPT_COMMAND='__vte_prompt_command; printf "\033]0;%s\007" "$TERMINAL_TITLE"'
fi

# commit changes to builds repo
commit-builds

echo "time used: $((SECONDS - recorderStart)) seconds"

