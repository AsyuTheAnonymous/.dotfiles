{ config, lib, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    aircrack-ng
    wireshark
    nmap
    kismet
    wifite2
    metasploit
    john
    hashcat
    bettercap
  ];

  # boot.extraModulePackages = [ config.boot.kernelPackages.rtl8814au ];
  # boot.kernelModules = [ "8814au" ];

}