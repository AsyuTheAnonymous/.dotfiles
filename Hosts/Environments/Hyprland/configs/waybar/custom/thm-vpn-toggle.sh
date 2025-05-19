#!/usr/bin/env bash
# File location: /home/asyu/.dotfiles/Hosts/Environments/Hyprland/configs/waybar/custom/thm-vpn-toggle.sh

# VPN name in NetworkManager
VPN_NAME="TryHackMe"

# Check if VPN is active
if nmcli connection show --active | grep -q "$VPN_NAME"; then
    # VPN is connected, disconnect it
    nmcli connection down "$VPN_NAME"
    notify-send "THM VPN" "Disconnected" --icon=network-vpn-disconnected
else
    # VPN is not connected, connect it
    nmcli connection up "$VPN_NAME"
    notify-send "THM VPN" "Connected" --icon=network-vpn
fi