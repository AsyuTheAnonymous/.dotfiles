{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    brave
    vscode
    ghostty
    discord
    git
    spacedrive
    unzip
    neofetch
    tradingview
    btop
    parsec-bin
    code-cursor
    # atlauncher
    # minecraft
  ];






}