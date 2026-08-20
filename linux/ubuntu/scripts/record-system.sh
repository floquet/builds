#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Capture Ubuntu system information
{
    date

    echo
    echo "COMMAND: hostnamectl"
    hostnamectl

    echo
    echo "COMMAND: uname -a"
    uname -a

    echo
    echo "COMMAND: lsb_release -a"
    lsb_release -a

    echo
    echo "COMMAND: lscpu"
    lscpu

    echo
    echo "COMMAND: free -h"
    free -h

    echo
    echo "COMMAND: lsblk"
    lsblk

    echo
    echo "COMMAND: df -h"
    df -h

    echo
    echo "COMMAND: findmnt"
    findmnt
} > "${pSelf}/system.txt"


