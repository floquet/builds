# create connection DanLan
#! /usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

Initialize counters
counter=0
subcounter=0
start_time=${SECONDS}

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    subcounter=0
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step() {
    export subcounter=$((subcounter + 1))
    echo ""
    echo "  Substep ${counter}.${subcounter}: ${1}"
}

# create connection DanLan
sudo nmcli connection add \
    type ethernet \
        ifname enp86s0 \
            con-name DanLan \
                ipv4.method manual \
                    ipv4.addresses 10.10.10.4/24 \
                        ipv4.gateway "" \
                            ipv4.dns "" \
                                ipv6.method disabled

# DanLan must never be default
sudo nmcli connection modify DanLan \
    ipv4.never-default yes \
        connection.autoconnect yes

# remove temporaty address
sudo ip addr del 10.10.10.4/24 dev enp86s0

# bring up DanLan
sudo nmcli connection up DanLan

# interrogate
ip -br addr
ip route
nmcli device status



