{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    brave
    vscode
    ghostty
    discord
    git
    nemo
    neofetch
    tradingview
    btop
    parsec-bin
    code-cursor
    # File Manager + plugins
    # krusader
    # unzip
    # kompare
    # kate
  ];






}