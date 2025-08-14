#!/usr/bin/env bash
set -euo pipefail
VPN_DIR="${1:-/home/asyu/vpn/proton}"
shopt -s nullglob
for f in "$VPN_DIR"/*.ovpn; do
  base="$(basename "$f" .ovpn)"
  name="proton-${base}"
  if nmcli -t -f NAME con show | awk -F: '{print $1}' | grep -qx "$name"; then
    echo "Already imported: $name"
    continue
  fi
  nmcli --terse connection import type openvpn file "$f" \
    && nmcli con modify "$base" connection.id "$name" \
    && echo "Imported: $name"
done
