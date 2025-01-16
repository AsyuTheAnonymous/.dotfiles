{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    brave
    vscode
    ghostty
    discord
    git
    nemo-with-extensions
    unzip
    neofetch
    tradingview
    catppuccin-gtk
    parsec-bin
    juno-theme
    # atlauncher
    # minecraft
  ];






}