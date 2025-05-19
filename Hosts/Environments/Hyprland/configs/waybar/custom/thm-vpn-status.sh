#!/usr/bin/env bash
# File location: /home/asyu/.dotfiles/Hosts/Environments/Hyprland/configs/waybar/custom/thm-vpn-status.sh

# VPN name in NetworkManager
VPN_NAME="TryHackMe"

# Check if VPN is active
if nmcli connection show --active | grep -q "$VPN_NAME"; then
    # VPN is connected
    echo '{"text": "THM: On", "class": "vpn-on", "tooltip": "Click to disconnect from THM VPN"}'
else
    # VPN is not connected
    echo '{"text": "THM: Off", "class": "vpn-off", "tooltip": "Click to connect to THM VPN"}'
fi