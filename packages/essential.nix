{ pkgs, lib, ... }:


{
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;
  
  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    vivaldi
    ghostty
    git
    nemo
    neofetch
    tradingview
    telegram-desktop
    btop
    pavucontrol
    parsec-bin
    protonmail-desktop
    catppuccin-sddm
    tree
    lolcat
    osu-lazer-bin
    localsend
    obs-studio
  ];
}
