{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    vivaldi
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
    catppuccin-sddm
    osu-lazer
  ];






}