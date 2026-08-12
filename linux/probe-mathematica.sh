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

machine=$(hostname -s)
results_dir="${HOME}/.info/mathematica"

new_step "Prepare Mathematica probe directory"

sub_step "mkdir -p ${results_dir}"
mkdir -p "${results_dir}"

# ----------------------------------------------------------------------

# Wolfram kernel

# ----------------------------------------------------------------------

new_step "Probe Wolfram kernel"

sub_step "command -v wolfram"
command -v wolfram 2>&1 | tee "${results_dir}/wolfram-path.txt"

sub_step "wolfram -version"
wolfram -version 2>&1 | tee "${results_dir}/wolfram-version.txt"

# ----------------------------------------------------------------------

# WolframScript

# ----------------------------------------------------------------------

new_step "Probe WolframScript"

sub_step "command -v wolframscript"
command -v wolframscript 2>&1 | tee "${results_dir}/wolframscript-path.txt"

sub_step "wolframscript -version"
wolframscript -version 2>&1 | tee "${results_dir}/wolframscript-version.txt"

# ----------------------------------------------------------------------

# Functional test

# ----------------------------------------------------------------------

new_step "Run Wolfram Language functional test"

sub_step "Print version and compute N[Pi,50]"

wolframscript 
-code 'Print[$Version]; Print[N[Pi,50]]' 
2>&1 | tee "${results_dir}/functional-test.txt"

# ----------------------------------------------------------------------

# Summary

# ----------------------------------------------------------------------

elapsed=$((SECONDS - start_time))

echo ""
echo "machine: ${machine}"
echo "results posted to:"
echo "  ${results_dir}"
echo ""

printf "time to probe Mathematica: %dh:%dm:%ds\n" 
$((elapsed / 3600)) 
$((elapsed % 3600 / 60)) 
$((elapsed % 60))

echo ""
echo "end: $(date)"
