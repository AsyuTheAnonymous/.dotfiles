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



}