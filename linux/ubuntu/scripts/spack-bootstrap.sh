#!/usr/bin/env bash

printf '%s\n' "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Aug 31 2026

# ----------------------------------------------------------------------
# Bootstrap location
# ----------------------------------------------------------------------

spack_bootstrap_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ----------------------------------------------------------------------
# Persistent locations
# ----------------------------------------------------------------------

spack_mirror="/mnt/tethys/spack_mirror"
spackticity="/mnt/tethys/spackticity"
spack_yaml="${spackticity}/$(hostname -s)/yaml"

# ----------------------------------------------------------------------
# Navigation
# ----------------------------------------------------------------------

gomirror() {
    cd "${spack_mirror}" || return
    pwd
}

gospackticity() {
    cd "${spackticity}" || return
    pwd
}

goyaml() {
    cd "${spack_yaml}" || return
    pwd
}

# ----------------------------------------------------------------------
# Load personal Spack tools
# ----------------------------------------------------------------------

l-spack() {
    source "${spack_bootstrap_dir}/spack-tools.sh"
}

# ----------------------------------------------------------------------
# Initialize Spack
#
# Run from the root of the Spack checkout.
# setup-env.sh establishes SPACK_ROOT.
# ----------------------------------------------------------------------

initspack() {

    if [[ ! -f share/spack/setup-env.sh ]]; then
        echo "ERROR: not in a Spack checkout"
        echo "missing:"
        echo "  $(pwd)/share/spack/setup-env.sh"
        return 1
    fi

    echo 'source share/spack/setup-env.sh'
    source share/spack/setup-env.sh

    echo 'l-spack'
    l-spack
}

# ----------------------------------------------------------------------
# Create fresh Spack checkout
#
# Default directory:
#
#     spack-${HOSTNAME}
#
# Keep only the two most recent commits.
# ----------------------------------------------------------------------

genesis() {

    local target="${1:-spack-${HOSTNAME}}"

    echo \
        "git clone --depth 2 -c feature.manyFiles=true https://github.com/spack/spack.git ${target}"

    git clone \
        --depth 2 \
        -c feature.manyFiles=true \
        https://github.com/spack/spack.git \
        "${target}"
}

