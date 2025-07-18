# Bug Bounty Reconnaissance Tools
{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # Import your existing FSRecon
  imports = [
    ./../../Common/Packages/Hacking/FSRecon/fsrecon.nix
  ];

  environment.systemPackages = with pkgs-unstable; [
    # Essential subdomain enumeration tools
    subfinder
    amass
    assetfinder
    dnsrecon
    knockpy
    sublist3r

    # Port scanning tools
    nmap
    masscan
    rustscan # Fast port scanner in Rust

    # Web discovery
    ffuf
    wfuzz
    gobuster
    feroxbuster

    # Content discovery
    nuclei
    httpx
    meg
    waybackurls
    gau # Get All URLs
    unfurl # Extract and analyze domains from URLs

    # Visual recon
    aquatone
    gowitness

    # Infrastructure analysis
    shodan-cli

    # Structured outputs
    jq # JSON parsing
    anew # Append lines from stdin to a file if they don't already exist

    # Resource-friendly tools for laptop use
    httprobe # Fast HTTP probe (better for laptop than httpx in some cases)
  ];

  # Create specific configuration files for laptop
  environment.etc = {
    "bugbounty/amass.yaml".text = ''
      # Resource-optimized Amass configuration for laptop
      output:
        dir: $HOME/BugBounty/amass_output

      # Reduced resource settings for laptop
      options:
        timeout: 60
        max_dns_queries: 1000
        max_depth: 2
        active: false  # Disable active by default, enable manually when needed
    '';

    # Reduced scope Nuclei config for laptop resources
    "bugbounty/nuclei-config.yaml".text = ''
      concurrency: 15
      rate-limit: 150
      timeout: 5
      retries: 1
      templates:
        - cves
        - vulnerabilities
      # Exclude heavy templates by default
      exclude:
        - dos
        - fuzzing
        - miscellaneous
        - default-logins
    '';
  };

  # Create helper scripts for recon
  environment.systemPackages = let
    recon-script = pkgs.writeShellScriptBin "laptop-recon" ''
      #!/usr/bin/env bash
      # Lightweight recon script for laptop use

      if [ $# -lt 1 ]; then
        echo "Usage: laptop-recon <domain>"
        exit 1
      fi

      DOMAIN=$1
      OUTDIR="$HOME/BugBounty/Targets/$DOMAIN/recon"
      mkdir -p "$OUTDIR"

      # Subdomain enumeration with resource consideration
      echo "[+] Performing lightweight subdomain enumeration..."
      subfinder -d "$DOMAIN" -o "$OUTDIR/subdomains.txt"

      # Probe for live hosts (more efficient than httpx for initial sweep)
      echo "[+] Probing for live hosts..."
      cat "$OUTDIR/subdomains.txt" | httprobe > "$OUTDIR/live_hosts.txt"

      # Basic port scan (limited scope)
      echo "[+] Running quick port scan on live hosts..."
      cat "$OUTDIR/live_hosts.txt" | cut -d/ -f3 | sort -u | nmap -T3 -p 80,443,8080,8443 -iL - -oA "$OUTDIR/quick_ports"

      # Take screenshots of discovered websites
      echo "[+] Taking screenshots of discovered websites..."
      cat "$OUTDIR/live_hosts.txt" | gowitness file -f - -P "$OUTDIR/screenshots" --no-http

      echo "[+] Lightweight recon completed! Results saved to $OUTDIR"
      echo "[+] For more intensive scans, consider using the full-recon script when connected to power."
    '';

    power-recon-script = pkgs.writeShellScriptBin "power-recon" ''
      #!/usr/bin/env bash
      # Full recon script for when laptop is plugged in

      if [ $# -lt 1 ]; then
        echo "Usage: power-recon <domain>"
        exit 1
      fi

      # Check if laptop is on AC power
      if [ "$(cat /sys/class/power_supply/*/online 2>/dev/null | grep 1 | wc -l)" -eq 0 ]; then
        echo "[!] Laptop is not connected to power. This script may drain your battery quickly."
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
          exit 1
        fi
      fi

      # Set CPU governor to performance
      echo "[+] Setting CPU governor to performance mode..."
      sudo cpupower frequency-set -g performance

      DOMAIN=$1
      OUTDIR="$HOME/BugBounty/Targets/$DOMAIN/recon"
      mkdir -p "$OUTDIR"

      # Run fsrecon with adjusted parameters for more thorough scanning
      echo "[+] Running Full Spectrum Recon..."
      fsrecon "$DOMAIN"

      # Return CPU governor to powersave when done
      echo "[+] Setting CPU governor back to powersave mode..."
      sudo cpupower frequency-set -g powersave

      echo "[+] Full power recon completed! Results saved to $OUTDIR"
    '';
  in [
    recon-script
    power-recon-script
  ];
}
