{ config, lib, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    aircrack-ng
    wireshark
    nmap
    kismet
    reaver
    wifite
  ];



}