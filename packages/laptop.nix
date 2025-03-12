{ pkgs, lib, ... }:


{
  imports = [
    ./eth.nix
  ];
  msty = pkgs.callPackage ./custom/msty {}; 

    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;
  
  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    wirelesstools
    usbutils
    iw
    brave
    git
    libreoffice
    okular
    neofetch
    btop
    pavucontrol
    parsec-bin
    protonmail-desktop
    tree
    localsend
    vscode
    nixd
    nil
    bottles
    impression
    gnome-boxes
    unzip
    unrar
    zip
  ];
}
