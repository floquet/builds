#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Capture network configuration and state
{
    date

    echo
    echo "COMMAND: ip -br addr"
    ip -br addr

    echo
    echo "COMMAND: ip route"
    ip route

    echo
    echo "COMMAND: ip -6 route"
    ip -6 route

    echo
    echo "COMMAND: nmcli device status"
    nmcli device status 2>/dev/null || echo "nmcli not available in WSL"

    echo
    echo "COMMAND: nmcli connection show"
    nmcli connection show 2>/dev/null || echo "nmcli not available in WSL"

    echo
    echo "COMMAND: resolvectl status"
    resolvectl status

    echo
    echo "COMMAND: ss -tulpn"
    ss -tulpn

    echo
    echo "COMMAND: ip neigh"
    ip neigh
} > "${pSelf}/network.txt"


