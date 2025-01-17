{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    brave
    vscode
    ghostty
    discord
    git
    nautilus
    unzip
    neofetch
    tradingview
    btop
    catppuccin-gtk
    parsec-bin
    juno-theme
    # atlauncher
    # minecraft
  ];






}