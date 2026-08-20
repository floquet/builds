#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Capture development toolchain versions
{
    date

    for cmd in \
        bash \
        gcc \
        g++ \
        gfortran \
        caf \
        python3 \
        git \
        cmake \
        make \
        nvim \
        vim \
        perl \
        ruby \
        java
    do
        echo
        echo "COMMAND: ${cmd} --version"

        if command -v "${cmd}" > /dev/null 2>&1; then
            command "${cmd}" --version 2>&1 | head -n 5
        else
            echo "NOT FOUND"
        fi
    done

} > "${pSelf}/toolchain.txt"


