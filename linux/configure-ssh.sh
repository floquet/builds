#!/usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Initialize counters

counter=0
subcounter=0
start_time=${SECONDS}

# Count steps in batch process

function new_step() {
counter=$((counter + 1))
subcounter=0
echo ""
echo "Step ${counter}: ${1}"
}

function sub_step() {
subcounter=$((subcounter + 1))
echo ""
echo "  Substep ${counter}.${subcounter}: ${1}"
}

# ----------------------------------------------------------------------

# Machine identity

# ----------------------------------------------------------------------

new_step "Identify machine"

machine=$(hostname -s)

sub_step "Machine hostname"
echo "  machine = ${machine}"

# ----------------------------------------------------------------------

# SSH directory

# ----------------------------------------------------------------------

new_step "Prepare SSH directory"

ssh_dir="${HOME}/.ssh"

sub_step "Create ${ssh_dir}"
mkdir -p "${ssh_dir}"

sub_step "Set SSH directory permissions to 700"
chmod 700 "${ssh_dir}"

# ----------------------------------------------------------------------

# GitHub SSH key

# ----------------------------------------------------------------------

new_step "Create GitHub SSH key"

github_key="${ssh_dir}/id_ed25519_${machine}_github"

sub_step "Generate Ed25519 key without a passphrase"
echo "  private key: ${github_key}"
echo "  public key:  ${github_key}.pub"

ssh-keygen \
-t ed25519 \
-f "${github_key}" \
-C "${machine}-github" \
-N ""

sub_step "Display GitHub public key"
cat "${github_key}.pub"

sub_step "Display GitHub key fingerprint"
ssh-keygen -lf "${github_key}.pub"

# ----------------------------------------------------------------------

# Bitbucket SSH key

# ----------------------------------------------------------------------

new_step "Create Bitbucket SSH key"

bitbucket_key="${ssh_dir}/id_ed25519_${machine}_bitbucket"

sub_step "Generate Ed25519 key without a passphrase"
echo "  private key: ${bitbucket_key}"
echo "  public key:  ${bitbucket_key}.pub"

ssh-keygen \
-t ed25519 \
-f "${bitbucket_key}" \
-C "${machine}-bitbucket" \
-N ""

sub_step "Display Bitbucket public key"
cat "${bitbucket_key}.pub"

sub_step "Display Bitbucket key fingerprint"
ssh-keygen -lf "${bitbucket_key}.pub"

# ----------------------------------------------------------------------

# Permissions

# ----------------------------------------------------------------------

new_step "Set SSH key permissions"

sub_step "Protect private keys"
chmod 600 "${github_key}"
chmod 600 "${bitbucket_key}"

sub_step "Set public key permissions"
chmod 644 "${github_key}.pub"
chmod 644 "${bitbucket_key}.pub"

# ----------------------------------------------------------------------

# Summary

# ----------------------------------------------------------------------

new_step "Summarize SSH keys"

echo ""
echo "GitHub:"
echo "  private:     ${github_key}"
echo "  public:      ${github_key}.pub"
echo "  description: ${machine}-github"

echo ""
echo "Bitbucket:"
echo "  private:     ${bitbucket_key}"
echo "  public:      ${bitbucket_key}.pub"
echo "  description: ${machine}-bitbucket"

echo ""
echo "The .pub files may be registered with the corresponding services."
echo "The private key files must remain on this machine."

elapsed=$((SECONDS - start_time))

echo ""

printf "time to configure SSH keys: %dh:%dm:%ds\n" 
$((elapsed / 3600)) 
$((elapsed % 3600 / 60)) 
$((elapsed % 60))

echo ""
echo "end: $(date)"
