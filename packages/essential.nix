{ pkgs, lib, ... }:


{
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;
  
  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    vivaldi
    git
    libreoffice
    okular
    neofetch
    tradingview
    btop
    pavucontrol
    parsec-bin
    protonmail-desktop
    catppuccin-sddm
    tree
    lolcat
    localsend
    cmatrix
    vlc
  ];
}
