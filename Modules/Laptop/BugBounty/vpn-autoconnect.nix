#!/usr/bin/env bash
# VPN Autoconnect script for bug bounty
# Usage: Place this script in NetworkManager dispatcher scripts directory

INTERFACE="$1"
STATUS="$2"
VPN_NAME="BugBountyVPN"  # Change this to your actual VPN connection name
LOG_FILE="/var/log/vpn-autoconnect.log"

# Create log file if it doesn't exist
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

log() {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Only run on specific network interface changes
if [ "$INTERFACE" = "lo" ]; then
    exit 0
fi

# Check if we're connected to a network
if [ "$STATUS" = "up" ]; then
    log "Interface $INTERFACE is up"
    
    # Get current network SSID for WiFi
    if [ -f "/sys/class/net/$INTERFACE/uevent" ] && grep -q "DEVTYPE=wlan" "/sys/class/net/$INTERFACE/uevent"; then
        SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        log "Connected to WiFi network: $SSID"
        
        # Skip VPN connection on trusted networks
        # Add your home/trusted WiFi networks here
        if [[ "$SSID" == "MyHomeWiFi" || "$SSID" == "Office-Secure" ]]; then
            log "Connected to trusted network $SSID. Not activating VPN."
            exit 0
        fi
    fi
    
    # Check if VPN is already active
    VPN_ACTIVE=$(nmcli connection show --active | grep "$VPN_NAME")
    
    if [ -z "$VPN_ACTIVE" ]; then
        log "VPN not active. Attempting to connect to $VPN_NAME"
        
        # Make security check
        # Wait for reliable connectivity before connecting
        sleep 5
        
        # Check if we have Internet connectivity
        if ping -c 1 -W 5 8.8.8.8 &> /dev/null; then
            log "Internet connectivity confirmed. Connecting VPN..."
            
            # Connect to VPN
            nmcli connection up id "$VPN_NAME" &>> "$LOG_FILE"
            
            # Check if connection was successful
            if [ $? -eq 0 ]; then
                log "Successfully connected to $VPN_NAME"
                
                # Notify user
                sudo -u $(logname) DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $(logname))/bus notify-send "Bug Bounty VPN" "Connected to $VPN_NAME" --icon=network-vpn
            else
                log "Failed to connect to $VPN_NAME"
                
                # Notify user of failure
                sudo -u $(logname) DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $(logname))/bus notify-send "Bug Bounty VPN" "Failed to connect to $VPN_NAME" --icon=network-error --urgency=critical
            fi
        else
            log "No Internet connectivity. VPN connection deferred."
        fi
    else
        log "VPN $VPN_NAME is already active"
    fi
fi

# If the interface is going down and the VPN is using it
if [ "$STATUS" = "down" ]; then
    log "Interface $INTERFACE is down"
    
    # Get the active VPN connection and its device
    VPN_INFO=$(nmcli -t -f NAME,DEVICE connection show --active | grep "$VPN_NAME")
    
    if [ -n "$VPN_INFO" ]; then
        VPN_DEV=$(echo "$VPN_INFO" | cut -d: -f2)
        
        # If VPN is using the interface that's going down, disconnect it gracefully
        if [ "$VPN_DEV" = "$INTERFACE" ]; then
            log "Interface $INTERFACE used by VPN is going down. Disconnecting VPN gracefully."
            nmcli connection down id "$VPN_NAME" &>> "$LOG_FILE"
        fi
    fi
fi

exit 0