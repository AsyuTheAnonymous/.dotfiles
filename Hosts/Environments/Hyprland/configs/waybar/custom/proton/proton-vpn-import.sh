#!/usr/bin/env bash
# File location: ~/import-thm-vpn.sh
# Run this ONCE to import your OpenVPN config into NetworkManager

# VPN configuration
VPN_NAME="ProtonVPN"
VPN_CONFIG="/home/asyu/vpn/proton/se-au-01.protonvpn.udp.ovpn"

# Import the VPN configuration
echo "Importing Proton VPN configuration..."
sudo nmcli connection import type openvpn file "$VPN_CONFIG"

# Rename connection if necessary
if ! nmcli connection show | grep -q "$VPN_NAME"; then
    IMPORTED_NAME=$(nmcli -g NAME connection show | grep -i "proton" | head -n 1)
    if [ -n "$IMPORTED_NAME" ]; then
        sudo nmcli connection modify "$IMPORTED_NAME" connection.id "$VPN_NAME"
        echo "VPN connection renamed to '$VPN_NAME'"
    fi
fi

echo "Import complete. Your VPN is now available as '$VPN_NAME' in NetworkManager."