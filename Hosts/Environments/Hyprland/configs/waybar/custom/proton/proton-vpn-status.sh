#!/usr/bin/env bash
set -euo pipefail

# Optional: scope to connections that start with "proton-"
ACTIVE_VPNS=$(nmcli -t -f NAME,TYPE con show --active | awk -F: '$2=="vpn"{print $1}')

if [[ -z "${ACTIVE_VPNS}" ]]; then
  # Disconnected
  jq -n --arg text "󰖂  Proton: off" \
        --arg class "disconnected" \
        --arg tooltip "ProtonVPN (OpenVPN): disconnected" \
        '{text:$text, class:$class, tooltip:$tooltip}'
  exit 0
fi

# If multiple VPNs, show the first
VPN_NAME=$(echo "$ACTIVE_VPNS" | head -n1)

# Shorten display if we use "proton-<file>"
DISPLAY_NAME="${VPN_NAME#proton-}"

# Try to show the VPN-assigned IP on tun0 (no external IP probe for speed)
TUN_IP=$(ip -o -4 addr show dev tun0 2>/dev/null | awk "{print \$4}" | cut -d/ -f1 | head -n1)
[[ -z "${TUN_IP:-}" ]] && TUN_IP="(no tun0 ip)"

jq -n \
  --arg text "  Proton: ${DISPLAY_NAME}" \
  --arg class "connected" \
  --arg tooltip "Connected: ${VPN_NAME}\nTUN IP: ${TUN_IP}" \
  '{text:$text, class:$class, tooltip:$tooltip}'
