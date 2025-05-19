#!/usr/bin/env bash

# Use absolute paths (no ~)
VPN_CONFIG="/home/asyu/VPN/THM/thm.ovpn"  # Change this to your actual config filename

# Check if VPN is connected
if pgrep -f "openvpn --config $VPN_CONFIG" > /dev/null; then
    # VPN is connected, disconnect it
    sudo pkill -f "openvpn --config $VPN_CONFIG"
    notify-send "THM VPN" "Disconnected" --icon=network-vpn-disconnected
    echo '{"text": "THM: Off", "class": "vpn-off", "tooltip": "Click to connect to THM VPN"}'
else
    # VPN is not connected, connect it
    sudo openvpn --config "$VPN_CONFIG" --daemon
    notify-send "THM VPN" "Connected" --icon=network-vpn
    echo '{"text": "THM: On", "class": "vpn-on", "tooltip": "Click to disconnect from THM VPN"}'
fi
