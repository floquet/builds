#!/usr/bin/env bash

printf '%s\n' "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# ----------------------------------------------------------------------
# Verify Spack initialization
# ----------------------------------------------------------------------

if [[ -z "${SPACK_ROOT:-}" ]]; then
    echo "ERROR: SPACK_ROOT is not defined."
    echo
    echo "Initialize Spack first:"
    echo
    echo "  initspack"
    return 1
fi

# ----------------------------------------------------------------------
# Navigation
# ----------------------------------------------------------------------

gospack() {
    cd "${SPACK_ROOT}" || return
    pwd
}

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------

scgcm() {
    echo 'spack config get compilers'
    spack config get compilers
}

scgcn() {
    echo 'spack config get config'
    spack config get config
}

scgmi() {
    echo 'spack config get mirrors'
    spack config get mirrors
}

scgmo() {
    echo 'spack config get modules'
    spack config get modules
}

scgpa() {
    echo 'spack config get packages'
    spack config get packages
}

scgre() {
    echo 'spack config get repos'
    spack config get repos
}

# ----------------------------------------------------------------------
# Configuration provenance
# ----------------------------------------------------------------------

scbcm() {
    echo 'spack config blame compilers'
    spack config blame compilers
}

scbcn() {
    echo 'spack config blame config'
    spack config blame config
}

scbmi() {
    echo 'spack config blame mirrors'
    spack config blame mirrors
}

scbmo() {
    echo 'spack config blame modules'
    spack config blame modules
}

scbpa() {
    echo 'spack config blame packages'
    spack config blame packages
}

scbre() {
    echo 'spack config blame repos'
    spack config blame repos
}

# ----------------------------------------------------------------------
# Current context
# ----------------------------------------------------------------------

spack_where() {

    echo
    echo "Spack context"
    echo
    echo "  hostname      : $(hostname -s)"
    echo "  SPACK_ROOT    : ${SPACK_ROOT}"
    echo "  spack_mirror  : ${spack_mirror}"
    echo "  spacktivity   : ${spacktivity}"
    echo "  spack_yaml    : ${spack_yaml}"
    echo
}

# ----------------------------------------------------------------------
# Report current context when loaded
# ----------------------------------------------------------------------

spack_where

