{pkgs, ...}: {
  imports = [
    ./../Common/common.nix
    ./Gaming/gaming.nix
    ./Usb/usb.nix
    ./Unstable/unstable.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for my desktop system
  environment.systemPackages = with pkgs; [
    pcmanfm
    libreoffice
    tradingview
    catppuccin-sddm
    catppuccin-gtk
    mpv
    numix-icon-theme
    # (pkgs.callPackage ./custom/msty {})
  ];
}
