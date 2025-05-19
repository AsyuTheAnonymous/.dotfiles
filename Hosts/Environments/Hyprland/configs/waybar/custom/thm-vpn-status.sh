#!/bin/bash

# Path to your THM VPN config
VPN_CONFIG="$HOME/VPN/THM/thm.ovpn"  # Change this to your actual config filename

while true; do
    if pgrep -f "openvpn --config $VPN_CONFIG" > /dev/null; then
        # VPN is connected
        echo '{"text": "THM: On", "class": "vpn-on", "tooltip": "Click to disconnect from THM VPN"}'
    else
        # VPN is not connected
        echo '{"text": "THM: Off", "class": "vpn-off", "tooltip": "Click to connect to THM VPN"}'
    fi
    sleep 5
done