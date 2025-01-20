{config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    vivaldi
    ghostty
    git
    nemo
    neofetch
    tradingview
    btop
    parsec-bin
    protonmail-desktop
    protonvpn-gui
    catppuccin-sddm
    flameshot
    tree
    lolcat
  ];






}