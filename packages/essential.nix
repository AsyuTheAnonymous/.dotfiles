{ pkgs, ... }:


{
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;
  
  # Open Tablet Driver
  hardware.opentabletdriver.enable = true;
  # hardware.opentabletdriver.daemon.enable = true;

  # hardware.opentabletdriver.blacklistedKernelModules = [ "hid-uclogic" ];


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
    protonvpn-gui
    catppuccin-sddm
    flameshot
    tree
    lolcat
    themechanger
    osu-lazer-bin
    localsend
    opentabletdriver
  ];






}
