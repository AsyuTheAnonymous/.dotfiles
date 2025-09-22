{ config, pkgs-unstable, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs-unstable; [
    # Proxy Interceptors
    caido
    burpsuite

    # Finding Subdomains
    subfinder
    assetfinder
    amass
    findomain

    # Checking Live Hosts 
    httpx

    # Historicals
    waybackurls
    waymore
    gau   

    # Content Discovery/Parameter Fuzzing
    ffuf
    feroxbuster

    # Webpage Screenshotter
    gowitness

    # Port Scanning
    rustscan
    nmap

    # Injection Testing/Vuln Scanning
    sqlmap       # SQLi
    dalfox       # XSS
    nuclei       # Multi-purpose vuln scanner
    nikto        # Web server vulns

    # API / SSRF
    interactsh
    postman
    arjun

    # Auth / Access Testing
    hydra        # Login brute force
    jwt-cli     # JWT tampering

    # Secrets / Info Leaks
    katana
    trufflehog   # secret scanning
    seclists
    jq

    # Network Analysis
    wireshark


    # Optional, uncomment when needed:
    # graphqlmap altair
    # amass
    # dalfox
    # feroxbuster
    # nikto
  ];

  programs.wireshark = {
    enable = true; # keep if you want packet captures
    dumpcap.enable = true;
  };

    # Wifi "Adapter" drivers
  boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
  boot.kernelModules = ["8814au"];

  # THM Labs
  networking.hosts = {
    "10.10.11.80" = ["editor.htb" "wiki.editor.htb"];

  };


}

