#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"
	
# capture machine settings
date > "${pSelf}/alias.txt"
echo "alias" >> "${pSelf}/alias.txt"
alias >> "${pSelf}/alias.txt"

