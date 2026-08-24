#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"
counter=0; start_time=${SECONDS}
function new_step() { counter=$((counter + 1)); echo -e "\nStep ${counter}: ${1}"; substep_count=0; }
function sub_step() { echo -e "\n  Substep ${counter}.${substep_count}: ${2}"; }

key_name="id_ed25519_gitlab_com"
new_step Set key_name="${key_name}"

new_step "Generate New Ed25519 Key: ssh-keygen -t ed25519 -C \"wsl-ubuntu-dantopa\" -f ~/.ssh/i${key_name}d_ed25519_gitlab_com -N \"\""
    #-t: type, -C: comment, -f: filename
    ssh-keygen -t ed25519 -C "wsl-ubuntu-dantopa" -f ~/.ssh/${key_name} -N ""

new_step "Secure Permissions"
    sub_step "1" "Set directory and file permissions"
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519
    chmod 644 ~/.ssh/id_ed25519.pub

new_step "Start ssh agent"
    eval "$(ssh-agent -s)"

new_step "Sdd ssh key"
    ssh-add ~/.ssh/${key_name}

new_step "Output Public Key to use with Github (https://gitlab.com/-/user_settings/ssh_keys)"
    cat ~/.ssh/${key_name}
    echo -e "\n[!] COPY THE STRING ABOVE TO GITLAB SETTINGS"

new_step "tree -L 1 ~/.ssh"
    tree -L 1 ~/.ssh

new_step "Check coonection: ssh -T git@gitlab.com"
  ssh -T git@gitlab.com || echo "Check if your GitLab instance uses a different domain"

elapsed=$((${SECONDS} - ${start_time}))
printf 'elapsed time: %dh:%dm:%ds\n' $((${elapsed}/3600)) $((${elapsed}%3600/60)) $((${elapsed}%60))
