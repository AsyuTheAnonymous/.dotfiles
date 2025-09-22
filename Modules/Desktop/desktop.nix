{pkgs, ...}: {
  imports = [
    ./../Common/common.nix
    ./Gaming/gaming.nix
    ./Usb/usb.nix
    ./Unstable/unstable.nix
    ./Terminals/Warp/warp.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for my desktop system
  environment.systemPackages = with pkgs; [
    android-tools
    nodejs_22
    pcmanfm
    libreoffice
    tradingview
    catppuccin-sddm
    catppuccin-gtk
    mpv
    numix-icon-theme
    # (pkgs.callPackage ./custom/msty {})
  ];
  #Openrgb
  services.hardware.openrgb.enable = true;
}
