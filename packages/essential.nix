{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    brave
    ghostty
    discord
    git
    nemo
    neofetch
    tradingview
    btop
    parsec-bin
    protonmail-desktop
    protonvpn-gui
  ];






}