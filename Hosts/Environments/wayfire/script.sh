#!/usr/bin/env bash
# This script diagnoses XDG Portal issues in Wayfire on NixOS

echo "====== XDG Portal Diagnostic Tool ======"
echo "Checking environment variables..."

# Check critical environment variables
echo -e "\nEnvironment Variables:"
echo "XDG_CURRENT_DESKTOP: ${XDG_CURRENT_DESKTOP:-NOT SET}"
echo "XDG_SESSION_TYPE: ${XDG_SESSION_TYPE:-NOT SET}"
echo "WAYLAND_DISPLAY: ${WAYLAND_DISPLAY:-NOT SET}"
echo "DISPLAY: ${DISPLAY:-NOT SET}"

# Check if portal services are running
echo -e "\nChecking portal services:"
if systemctl --user is-active xdg-desktop-portal.service &>/dev/null; then
    echo "✅ xdg-desktop-portal.service is running"
else
    echo "❌ xdg-desktop-portal.service is NOT running"
fi

if systemctl --user is-active xdg-desktop-portal-wlr.service &>/dev/null; then
    echo "✅ xdg-desktop-portal-wlr.service is running"
else
    echo "❌ xdg-desktop-portal-wlr.service is NOT running"
fi

if systemctl --user is-active xdg-desktop-portal-gtk.service &>/dev/null; then
    echo "✅ xdg-desktop-portal-gtk.service is running"
else
    echo "❌ xdg-desktop-portal-gtk.service is NOT running"
fi

# Check dbus interfaces
echo -e "\nChecking D-Bus portal interfaces:"
if gdbus introspect --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop &>/dev/null; then
    echo "✅ Portal D-Bus interface is available"
    
    # Check specific portal interfaces
    INTERFACES=$(gdbus introspect --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop | grep -o "interface org.freedesktop.portal.[A-Za-z0-9.]*" | cut -d ' ' -f 2)
    
    echo -e "\nAvailable portal interfaces:"
    echo "$INTERFACES"
else
    echo "❌ Portal D-Bus interface is NOT available"
fi

# Check portal configuration
echo -e "\nChecking portal configuration files:"
if [ -f /etc/xdg/xdg-desktop-portal/Wayfire-portals.conf ]; then
    echo "✅ Wayfire-portals.conf exists in /etc/xdg/xdg-desktop-portal/"
    echo "Contents:"
    cat /etc/xdg/xdg-desktop-portal/Wayfire-portals.conf
else
    echo "❌ No Wayfire-portals.conf in /etc/xdg/xdg-desktop-portal/"
fi

if [ -f ~/.config/xdg-desktop-portal/Wayfire-portals.conf ]; then
    echo "✅ Wayfire-portals.conf exists in ~/.config/xdg-desktop-portal/"
    echo "Contents:"
    cat ~/.config/xdg-desktop-portal/Wayfire-portals.conf
else
    echo "❌ No Wayfire-portals.conf in ~/.config/xdg-desktop-portal/"
fi

# Check installed portal packages
echo -e "\nChecking installed portal packages:"
if command -v nix-env &>/dev/null; then
    echo "Installed portal packages:"
    nix-env -q 'xdg-desktop-portal*' || echo "No portal packages found in user environment"
    echo -e "\nSystem packages:"
    nix-store -q --requisites /run/current-system | grep -i 'xdg-desktop-portal'
else
    echo "nix-env not found, skipping package check"
fi

# Check NixOS configuration
echo -e "\nChecking NixOS configuration:"
if [ -f /etc/nixos/configuration.nix ]; then
    echo "Portal configuration in /etc/nixos/configuration.nix:"
    grep -A 10 "xdg.portal" /etc/nixos/configuration.nix || echo "No xdg.portal configuration found"
else
    echo "❌ /etc/nixos/configuration.nix not found"
fi

# Check journal logs for portal errors
echo -e "\nRecent portal errors from journal:"
journalctl --user -u xdg-desktop-portal* -n 20 --no-pager | grep -i "error\|fail\|warn"

echo -e "\n====== Diagnostic Complete ======"
echo "For detailed explanations and fixes, review the output above"