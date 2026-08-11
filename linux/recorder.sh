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

new_step "Initialize recorder"

machine=$(hostname -s)
results_dir="${INFO_RESULTS_DIR:-${HOME}/.info/${machine}}"

sub_step "results_dir=${results_dir}"
mkdir -p "${results_dir}"

# ----------------------------------------------------------------------
# Helper: record command, date, blank line, output
# ----------------------------------------------------------------------

record_command() {

    command="$1"
    output_file="$2"

    sub_step "${command}"

    {
        echo "${command}"
        date
        echo ""
        eval "${command}"
    } > "${results_dir}/${output_file}" 2>&1
}

# ----------------------------------------------------------------------
# Operating system
# ----------------------------------------------------------------------

new_step "Record operating system"

record_command \
    "cat /etc/os-release" \
    "os-release.txt"

record_command \
    "uname -a" \
    "uname.txt"

record_command \
    "hostnamectl" \
    "hostnamectl.txt"

record_command \
    "uptime" \
    "uptime.txt"

# ----------------------------------------------------------------------
# CPU and architecture
# ----------------------------------------------------------------------

new_step "Record processor and architecture"

record_command \
    "lscpu" \
    "lscpu.txt"

record_command \
    "dpkg --print-architecture" \
    "architecture.txt"

record_command \
    "nproc" \
    "nproc.txt"

# ----------------------------------------------------------------------
# Memory
# ----------------------------------------------------------------------

new_step "Record memory"

record_command \
    "free -h" \
    "memory.txt"

record_command \
    "cat /proc/meminfo" \
    "meminfo.txt"

# ----------------------------------------------------------------------
# Storage
# ----------------------------------------------------------------------

new_step "Record storage"

record_command \
    "lsblk -o NAME,MODEL,SERIAL,SIZE,TYPE,FSTYPE,FSVER,LABEL,UUID,MOUNTPOINTS" \
    "lsblk.txt"

record_command \
    "df -hT" \
    "df.txt"

record_command \
    "findmnt" \
    "findmnt.txt"

record_command \
    "sudo fdisk -l" \
    "fdisk.txt"

# ----------------------------------------------------------------------
# PCI and USB hardware
# ----------------------------------------------------------------------

new_step "Record hardware"

record_command \
    "lspci -nnk" \
    "lspci.txt"

record_command \
    "lsusb" \
    "lsusb.txt"

record_command \
    "sudo lshw" \
    "lshw.txt"

record_command \
    "sudo lshw -short" \
    "lshw-short.txt"

# ----------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------

new_step "Record network"

record_command \
    "ip -br link" \
    "network-links.txt"

record_command \
    "ip -br addr" \
    "network-addresses.txt"

record_command \
    "ip route" \
    "network-routes.txt"

record_command \
    "ip neigh" \
    "network-neighbors.txt"

record_command \
    "ss -tulpn" \
    "network-sockets.txt"

# ----------------------------------------------------------------------
# Kernel and modules
# ----------------------------------------------------------------------

new_step "Record kernel"

record_command \
    "uname -r" \
    "kernel-release.txt"

record_command \
    "lsmod" \
    "kernel-modules.txt"

record_command \
    "sysctl -a" \
    "sysctl.txt"

# ----------------------------------------------------------------------
# APT package state
# ----------------------------------------------------------------------

new_step "Record APT state"

record_command \
    "dpkg-query -W -f='\${binary:Package}\t\${Version}\t\${Architecture}\n'" \
    "packages-installed.txt"

record_command \
    "apt-mark showmanual" \
    "packages-manual.txt"

record_command \
    "apt list --upgradable" \
    "packages-upgradable.txt"

record_command \
    "apt-cache stats" \
    "apt-cache-stats.txt"

# ----------------------------------------------------------------------
# APT repository configuration
# ----------------------------------------------------------------------

new_step "Record APT repositories"

record_command \
    "find /etc/apt -maxdepth 2 -type f -print" \
    "apt-files.txt"

record_command \
    "grep -Rhv '^[[:space:]]*#' /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null" \
    "apt-sources.txt"

# ----------------------------------------------------------------------
# Services
# ----------------------------------------------------------------------

new_step "Record services"

record_command \
    "systemctl list-unit-files" \
    "systemd-unit-files.txt"

record_command \
    "systemctl list-units --type=service --all" \
    "systemd-services.txt"

record_command \
    "systemctl --failed" \
    "systemd-failed.txt"

# ----------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------

new_step "Record shell environment"

record_command \
    "env | sort" \
    "environment-variables.txt"

record_command \
    "printf '%s\n' \"\$PATH\"" \
    "path.txt"

record_command \
    "ulimit -a" \
    "ulimit.txt"

# ----------------------------------------------------------------------
# Compilers and development tools
# ----------------------------------------------------------------------

new_step "Record development tools"

record_command \
    "gcc --version" \
    "gcc-version.txt"

record_command \
    "g++ --version" \
    "gxx-version.txt"

record_command \
    "gfortran --version" \
    "gfortran-version.txt"

record_command \
    "python3 --version" \
    "python-version.txt"

record_command \
    "git --version" \
    "git-version.txt"

record_command \
    "make --version" \
    "make-version.txt"

record_command \
    "cmake --version" \
    "cmake-version.txt"

# ----------------------------------------------------------------------
# Firmware / boot
# ----------------------------------------------------------------------

new_step "Record boot state"

record_command \
    "ls -l /boot" \
    "boot-directory.txt"

record_command \
    "sudo efibootmgr -v" \
    "efi-boot.txt"

# ----------------------------------------------------------------------
# Final summary
# ----------------------------------------------------------------------

new_step "Write recorder summary"

{
    echo "Machine state recorder"
    date
    echo ""
    echo "hostname:       ${machine}"
    echo "results_dir:    ${results_dir}"
    echo "kernel:         $(uname -r)"
    echo "architecture:   $(uname -m)"
} > "${results_dir}/recorder-summary.txt"

elapsed=$((${SECONDS} - ${start_time}))

echo ""
echo "results posted to ${results_dir}"
echo ""

printf 'elapsed time: %dh:%dm:%ds\n' \
    $((${elapsed} / 3600)) \
    $((${elapsed} % 3600 / 60)) \
    $((${elapsed} % 60))

echo ""
echo "end: $(date)"