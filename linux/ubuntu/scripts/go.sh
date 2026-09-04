#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# && ensures pwd runs whether or not cd is successful
alias goRepos='cd "${pRepos}" && pwd'
alias goGithub='cd "${pGithub}" && pwd'
alias goBuilds='cd "${pBuilds}" && pwd'
alias goUbuntu='cd "${pUbuntu}" && pwd'
alias goScripts='cd "${pScripts}" && pwd'
alias goFramework='cd "${pFramework}" && pwd'


