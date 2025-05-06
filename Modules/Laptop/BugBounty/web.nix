# Web Application Security Tools
{ config, pkgs, pkgs-unstable, ... }:

{
  # Import your existing XSStrike module
  imports = [
    ./../../Custom/XSStrike/xsstrike.nix
  ];

  environment.systemPackages = with pkgs-unstable; [
    # Web proxies (essentials)
    burpsuite
    zaproxy
    mitmproxy
    
    # Web scanners
    nikto
    wapiti
    sqlmap
    
    # Web vulnerability tools
    dalfox       # XSS finder
    xsser
    owasp-zap
    
    # Authentication testing
    hydra
    thc-hydra
    
    # Utilities
    whatweb      # Website fingerprinting
    wpscan       # WordPress vulnerability scanner
    
    # API testing
    postman
    insomnia
    
    # Web crawling & scraping
    gospider
    hakrawler
    
    # JavaScript analysis
    retire-js    # Scan for vulnerable JavaScript libraries
    npm-check-updates
    
    # Browser automation
    selenium-server
    chromedriver
    geckodriver
    
    # Browser extensions via native packages
    # These are especially useful on a laptop for quick testing
    (pkgs.writeShellScriptBin "install-bb-extensions" ''
      #!/usr/bin/env bash
      mkdir -p ~/.mozilla/extensions
      mkdir -p ~/.config/google-chrome/extensions
      
      # Set up Firefox security extensions (you'd download these via web)
      echo "Please install these Firefox extensions manually:"
      echo "- FoxyProxy"
      echo "- Wappalyzer"
      echo "- User-Agent Switcher"
      echo "- Cookie Editor"
      echo "- HackTools"
      
      # Set up Chrome extensions with similar process
      echo "Please install these Chrome extensions manually:"
      echo "- Wappalyzer"
      echo "- BuiltWith Technology Profiler"
      echo "- JSONView"
      echo "- EditThisCookie"
    '')
  ];
  
  # Configure system for web testing on laptop
  networking = {
    # Enable IP forwarding for proxying
    firewall = {
      allowedTCPPorts = [ 
        8080  # Burp
        8090  # ZAP 
        8000  # Python SimpleHTTPServer
        3000  # Node services
      ];
    };
    
    # Local hosts file entries for testing
    extraHosts = ''
      127.0.0.1 test-target.local
      127.0.0.1 vulnerable.test
    '';
  };
  
  # Create helper scripts for web testing
  environment.systemPackages = let
    web-enum-script = pkgs.writeShellScriptBin "web-enum" ''
      #!/usr/bin/env bash
      # Lightweight web enumeration script for laptop
      
      if [ $# -lt 1 ]; then
        echo "Usage: web-enum <url>"
        exit 1
      fi
      
      URL=$1
      DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')
      OUTDIR="$HOME/BugBounty/Targets/$DOMAIN/web"
      mkdir -p "$OUTDIR"
      
      echo "[+] Running WhatWeb scan..."
      whatweb -v -a 3 "$URL" > "$OUTDIR/whatweb.txt"
      
      echo "[+] Running Nikto scan (lightweight mode)..."
      nikto -host "$URL" -maxtime 15m -Tuning 1234 > "$OUTDIR/nikto.txt"
      
      echo "[+] Crawling website with Gospider..."
      gospider -s "$URL" -d 3 -c 5 -t 60 -o "$OUTDIR/gospider" > "$OUTDIR/gospider.txt"
      
      echo "[+] Collecting JavaScript files..."
      grep -r "\.js" "$OUTDIR/gospider" | grep -v "\.json" | sort -u > "$OUTDIR/js_files.txt"
      
      echo "[+] Scanning for potential parameters..."
      grep "=" "$OUTDIR/gospider.txt" | sort -u > "$OUTDIR/potential_params.txt"
      
      echo "[+] Extracting forms..."
      grep -r "form" "$OUTDIR/gospider" | grep -i "method=" > "$OUTDIR/forms.txt"
      
      echo "[+] Web enumeration complete! Results saved to $OUTDIR"
    '';
    
    xss-script = pkgs.writeShellScriptBin "xss-scan" ''
      #!/usr/bin/env bash
      # XSS scanning script optimized for laptop
      
      if [ $# -lt 1 ]; then
        echo "Usage: xss-scan <url> [param1,param2,...]"
        exit 1
      fi
      
      URL=$1
      PARAMS=$2
      DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')
      OUTDIR="$HOME/BugBounty/Targets/$DOMAIN/xss"
      mkdir -p "$OUTDIR"
      
      if [ -z "$PARAMS" ]; then
        echo "[+] No parameters specified, running DalFox in auto-discover mode..."
        dalfox url "$URL" -o "$OUTDIR/dalfox_results.txt"
      else
        echo "[+] Running DalFox with specified parameters..."
        dalfox url "$URL" -p "$PARAMS" -o "$OUTDIR/dalfox_results.txt"
      fi
      
      echo "[+] Running XSStrike for validation..."
      xsstrike --url "$URL" --params "$PARAMS" > "$OUTDIR/xsstrike_results.txt"
      
      echo "[+] XSS scanning complete! Results saved to $OUTDIR"
    '';
    
    sqli-script = pkgs.writeShellScriptBin "sqli-scan" ''
      #!/usr/bin/env bash
      # SQLi scanning script optimized for laptop resources
      
      if [ $# -lt 1 ]; then
        echo "Usage: sqli-scan <url> [param1,param2,...]"
        exit 1
      fi
      
      URL=$1
      PARAMS=$2
      DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')
      OUTDIR="$HOME/BugBounty/Targets/$DOMAIN/sqli"
      mkdir -p "$OUTDIR"
      
      echo "[+] Running SQLMap with conservative settings for laptop..."
      if [ -z "$PARAMS" ]; then
        sqlmap -u "$URL" --batch --level=1 --risk=1 --threads=2 --output-dir="$OUTDIR"
      else
        echo "[+] Testing specific parameters: $PARAMS"
        IFS=',' read -ra PARAM_ARRAY <<< "$PARAMS"
        for param in "${PARAM_ARRAY[@]}"; do
          sqlmap -u "$URL" -p "$param" --batch --level=1 --risk=1 --threads=2 --output-dir="$OUTDIR"
        done
      fi
      
      echo "[+] SQLi scanning complete! Results saved to $OUTDIR"
    '';
    
  in [
    web-enum-script
    xss-script
    sqli-script
  ];
  
  # Setup systemd services for background tools
  systemd.user.services = {
    burpsuite-headless = {
      description = "Burp Suite Headless Service";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.burpsuite}/bin/burpsuite --headless --project-file=%h/BugBounty/burp_projects/headless.burp --config-file=%h/BugBounty/burp_projects/headless.json";
        Restart = "on-failure";
      };
      wantedBy = [];  # Not auto-started, manual control
    };
  };
}