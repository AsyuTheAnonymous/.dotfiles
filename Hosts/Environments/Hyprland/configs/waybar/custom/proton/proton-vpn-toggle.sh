#!/usr/bin/env bash
set -euo pipefail

VPN_DIR="${PROTON_VPN_DIR:-/home/asyu/vpn/proton}"

# Choose which .ovpn to use:
# 1) If $PROTON_OVPN is set, use that exact file
# 2) Else pick the first *.ovpn in the directory
if [[ -n "${PROTON_OVPN:-}" ]]; then
  OVPN_FILE="$PROTON_OVPN"
else
  OVPN_FILE="$(find "$VPN_DIR" -maxdepth 1 -type f -name '*.ovpn' | head -n1 || true)"
fi

if [[ -z "${OVPN_FILE}" || ! -f "${OVPN_FILE}" ]]; then
  notify-send "ProtonVPN" "No .ovpn found in $VPN_DIR" || true
  exit 1
fi

BASE="$(basename "$OVPN_FILE" .ovpn)"
CON_NAME="proton-${BASE}"

# Is a Proton connection currently active?
ACTIVE_VPNS=$(nmcli -t -f NAME,TYPE con show --active | awk -F: '$2=="vpn"{print $1}')
if echo "$ACTIVE_VPNS" | grep -qx "$CON_NAME"; then
  # Connected -> disconnect
  nmcli con down id "$CON_NAME" || {
    notify-send "ProtonVPN" "Failed to disconnect $CON_NAME" || true
    exit 2
  }
  notify-send "ProtonVPN" "Disconnected $CON_NAME" || true
  exit 0
fi

# If not active, ensure the connection exists; import if needed
if ! nmcli -t -f NAME con show | awk -F: '{print $1}' | grep -qx "$CON_NAME"; then
  # Import; NM will name it after the file by default — capture that name
  IMPORT_OUT="$(nmcli --terse connection import type openvpn file "$OVPN_FILE" 2>&1 || true)"
  # Find the created name (nmcli prints it); fall back to filename
  CREATED_NAME="$(echo "$IMPORT_OUT" | sed -n 's/^connection.imported: //p' | head -n1)"
  [[ -z "${CREATED_NAME}" ]] && CREATED_NAME="$BASE"

  # Rename to our canonical id to keep scripts stable
  nmcli con modify "$CREATED_NAME" connection.id "$CON_NAME"
fi

# Bring it up
# First-time may prompt for creds unless stored; do one manual 'nmcli con up' in a terminal to save.
if ! nmcli con up id "$CON_NAME"; then
  notify-send "ProtonVPN" "Failed to connect $CON_NAME (check creds/polkit)" || true
  exit 3
fi

notify-send "ProtonVPN" "Connected $CON_NAME" || true
