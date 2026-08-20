#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# ----------------------------------------------------------------------
# Compiler
# ----------------------------------------------------------------------

q-compiler() {
    echo
    echo "=== COMPILER ==="

    echo "FC=${FC:-<unset>}"

    echo
    echo "command -v gfortran"
    command -v gfortran || true

    echo
    echo "gfortran --version"
    gfortran --version 2>/dev/null | head -n 2

    echo
    echo "command -v caf"
    command -v caf || true

    echo
    echo "caf --version"
    caf --version 2>/dev/null || true
}

# ----------------------------------------------------------------------
# CAF / OpenCoarrays
# ----------------------------------------------------------------------

q-caf() {
    echo
    echo "=== CAF / OPENCOARRAYS ==="

    echo "caf:"
    type -a caf 2>/dev/null || true

    echo
    echo "cafrun:"
    type -a cafrun 2>/dev/null || true

    echo
    echo "caf wrapper:"
    command -v caf 2>/dev/null || true

    echo
    echo "cafrun wrapper:"
    command -v cafrun 2>/dev/null || true

    echo
    echo "OpenCoarrays libraries:"
    ldconfig -p 2>/dev/null | grep -i caf || true
}

# ----------------------------------------------------------------------
# MPI carrier
# ----------------------------------------------------------------------

q-mpi() {
    echo
    echo "=== MPI ==="

    echo "mpicc:"
    type -a mpicc 2>/dev/null || true

    echo
    echo "mpifort:"
    type -a mpifort 2>/dev/null || true

    echo
    echo "mpif90:"
    type -a mpif90 2>/dev/null || true

    echo
    echo "mpirun:"
    type -a mpirun 2>/dev/null || true

    echo
    echo "mpiexec:"
    type -a mpiexec 2>/dev/null || true

    echo
    echo "MPI implementation:"
    mpirun --version 2>/dev/null | head -n 5 || true
}

# ----------------------------------------------------------------------
# Wrapper internals
# ----------------------------------------------------------------------

q-wrappers() {
    echo
    echo "=== WRAPPERS ==="

    if command -v mpifort >/dev/null 2>&1; then
        echo "mpifort --showme"
        mpifort --showme 2>/dev/null || true

        echo
        echo "mpifort --showme:command"
        mpifort --showme:command 2>/dev/null || true

        echo
        echo "mpifort --showme:compile"
        mpifort --showme:compile 2>/dev/null || true

        echo
        echo "mpifort --showme:link"
        mpifort --showme:link 2>/dev/null || true
    fi

    echo
    echo "caf wrapper contents:"
    local caf_path
    caf_path="$(command -v caf 2>/dev/null)"

    if [[ -n "$caf_path" ]]; then
        echo "$caf_path"
        head -n 40 "$caf_path" 2>/dev/null || true
    fi
}

# ----------------------------------------------------------------------
# Alternatives / package ownership
# ----------------------------------------------------------------------

q-selection() {
    echo
    echo "=== SYSTEM SELECTION ==="

    echo "update-alternatives: MPI"
    update-alternatives --display mpi 2>/dev/null || true

    echo
    echo "update-alternatives: mpirun"
    update-alternatives --display mpirun 2>/dev/null || true

    echo
    echo "Package ownership: caf"
    local path
    path="$(command -v caf 2>/dev/null)"
    [[ -n "$path" ]] && dpkg -S "$path" 2>/dev/null || true

    echo
    echo "Installed MPI / OpenCoarrays packages:"
    dpkg -l 2>/dev/null |
        grep -Ei 'openmpi|mpich|coarray|caf|open-coarrays' || true
}

# ----------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------

q-fortran-env() {
    echo
    echo "=== ENVIRONMENT ==="

    printf 'FC=%s\n'          "${FC:-<unset>}"
    printf 'CC=%s\n'          "${CC:-<unset>}"
    printf 'CXX=%s\n'         "${CXX:-<unset>}"
    printf 'F77=%s\n'         "${F77:-<unset>}"
    printf 'F90=%s\n'         "${F90:-<unset>}"
    printf 'OMPI_FC=%s\n'     "${OMPI_FC:-<unset>}"
    printf 'OMPI_CC=%s\n'     "${OMPI_CC:-<unset>}"
    printf 'I_MPI_F90=%s\n'   "${I_MPI_F90:-<unset>}"
    printf 'PATH=%s\n'        "$PATH"
    printf 'LD_LIBRARY_PATH=%s\n' "${LD_LIBRARY_PATH:-<unset>}"
}

# ----------------------------------------------------------------------
# One-shot summary
# ----------------------------------------------------------------------

q-fortran-stack() {
    echo
    echo "============================================================"
    echo " FORTRAN / CAF / MPI STACK"
    echo "============================================================"

    q-compiler
    q-caf
    q-mpi
    q-wrappers
    q-selection
    q-fortran-env

    echo
    echo "============================================================"
}

q-functions() {
    echo
    echo "=== FORTRAN STACK QUERY FUNCTIONS ==="
    echo
    printf "%-20s %s\n" "q-compiler"      "GNU Fortran and compiler selection"
    printf "%-20s %s\n" "q-caf"           "CAF and OpenCoarrays"
    printf "%-20s %s\n" "q-mpi"           "MPI implementation and commands"
    printf "%-20s %s\n" "q-wrappers"      "MPI and CAF wrapper internals"
    printf "%-20s %s\n" "q-selection"     "Alternatives and package selection"
    printf "%-20s %s\n" "q-fortran-env"   "Compiler/MPI environment variables"
    printf "%-20s %s\n" "q-fortran-stack" "Run all stack queries"
    printf "%-20s %s\n" "q-functions"     "Show this function catalog"
}

