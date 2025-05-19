cat > ~/.dotfiles/Hosts/Environments/Hyprland/configs/waybar/custom/thm-vpn-status.sh << 'EOF'
#!/bin/bash

# Use absolute paths (no ~)
VPN_CONFIG="/home/asyu/VPN/THM/thm.ovpn"  # Change this to your actual config filename

if pgrep -f "openvpn --config $VPN_CONFIG" > /dev/null; then
    # VPN is connected
    echo '{"text": "THM: On", "class": "vpn-on", "tooltip": "Click to disconnect from THM VPN"}'
else
    # VPN is not connected
    echo '{"text": "THM: Off", "class": "vpn-off", "tooltip": "Click to connect to THM VPN"}'
fi
EOF