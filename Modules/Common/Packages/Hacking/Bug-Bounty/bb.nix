{ config, pkgs-unstable, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs-unstable; [
    # Core 12 Foundation
    caido
    waybackurls       
    postman
    subfinder
    httpx
    katana
    ffuf
    arjun
    nuclei
    interactsh
    gowitness
    jq
    seclists

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

}

