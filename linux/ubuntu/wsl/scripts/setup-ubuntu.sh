#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

start_time=$SECONDS  # Record the start time

# Step counter
export counter=0
export subcounter=0

# Function for a new major step
function new_step() {
    counter=$((counter + 1))
    subcounter=0  # Reset sub-step counter
    echo ""
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Step ${counter}: ${1}"
}

# Function for sub-steps
function sub_step() {
    subcounter=$((subcounter + 1))
    echo "  Substep ${counter}.${subcounter}: ${1}"
}

# Function to print total elapsed time
function display_total_elapsed_time() {
    local total_elapsed_time=$((SECONDS - start_time))
    local total_minutes=$((total_elapsed_time / 60))
    local total_seconds=$((total_elapsed_time % 60))
    echo ""
    printf "Total elapsed time: %02d:%02d (MM:SS)\n" "$total_minutes" "$total_seconds"
}

new_step "sudo apt update"
          sudo apt update

new_step "sudo apt upgrade"
          sudo apt upgrate

new_step "Install development environment"
    sub_step "sudo apt install 

display_total_elapsed_time
