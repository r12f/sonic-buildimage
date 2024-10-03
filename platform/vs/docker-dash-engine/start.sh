#!/usr/bin/env bash

function rename_intf() {
    if ! sudo ifconfig $1 > /dev/null 2&>1; then
        if ! sudo ifconfig $2 > /dev/null 2&>1; then
            echo "Interface $1 is not found. BMv2 data plane will not work."
            exit 1
        fi
    else
        sudo ip link set dev $1 down
        sudo ip link set dev $1 name $2
        sudo ip link set dev $2 up
    fi
}

rename_intf eth1 vdp0
rename_intf eth2 vdp1

simple_switch_grpc --interface 0@vdp0 --interface 1@vdp1 --log-console --no-p4
