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

# Results directory

# ----------------------------------------------------------------------

results_dir="${HOME}/.info"

new_step "Create results directory"

sub_step "mkdir -p ${results_dir}"
          mkdir -p "${results_dir}"

# ----------------------------------------------------------------------

# Operating system

# ----------------------------------------------------------------------

new_step "Inspect operating system"

sub_step "uname -a"
          uname -a 2>&1 | tee "${results_dir}/uname.txt"

sub_step "cat /etc/os-release"
          cat /etc/os-release 2>&1 | tee "${results_dir}/os-release.txt"

# ----------------------------------------------------------------------

# Processor

# ----------------------------------------------------------------------

new_step "Inspect processor"

sub_step "lscpu"
          lscpu 2>&1 | tee "${results_dir}/lscpu.txt"

# ----------------------------------------------------------------------

# Memory

# ----------------------------------------------------------------------

new_step "Inspect memory"

sub_step "free -h"
          free -h 2>&1 | tee "${results_dir}/free.txt"

# ----------------------------------------------------------------------

# Storage

# ----------------------------------------------------------------------

new_step "Inspect storage"

sub_step "lsblk"
          lsblk 2>&1 | tee "${results_dir}/lsblk.txt"

# ----------------------------------------------------------------------

# PCI hardware

# ----------------------------------------------------------------------

new_step "Inspect PCI hardware"

sub_step "lspci -nnk"
          lspci -nnk 2>&1 | tee "${results_dir}/lspci.txt"

# ----------------------------------------------------------------------

# Network

# ----------------------------------------------------------------------

new_step "Inspect network"

sub_step "ip -br addr"
          ip -br addr 2>&1 | tee "${results_dir}/ip-address.txt"

# ----------------------------------------------------------------------

# Summary

# ----------------------------------------------------------------------

elapsed=$((SECONDS - start_time))

echo ""
echo "results posted to:"
echo "  ${results_dir}"
echo ""

printf "time to inspect machine: %dh:%dm:%ds\n" \
$((elapsed / 3600)) \
$((elapsed % 3600 / 60)) \
$((elapsed % 60))

echo ""
echo "end: $(date)"
