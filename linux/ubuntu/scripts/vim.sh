#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

alias vim='nvim'

# Single quotes: variables expand when the alias is invoked
alias   v='echo "vim $HOME/.${HOSTNAME}.sh"; vim "$HOME/.${HOSTNAME}.sh"'
alias  vc='echo "vim ${pScripts}/master.sh"; vim "${pScripts}/master.sh"'
alias  vm='echo "vim makefile";              vim makefile'
alias  vM='echo "vim Makefile";              vim Makefile'
alias vcl='echo "vim CMakeLists.txt";        vim CMakeLists.txt'

export EDITOR=nvim
export VISUAL=nvim

