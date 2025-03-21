{pkgs, ...}: {
  imports = [
    ./common.nix
    ./unstable/unstable.nix
    ./gaming/games.nix
    ./recording/obs.nix
    # Inserting a module here remove later
    ./../modules/helpers/nh/nh.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    vivaldi
    pcmanfm
    libreoffice
    tradingview
    catppuccin-sddm
    catppuccin-gtk
    mpv
    numix-icon-theme
    (pkgs.callPackage ./custom/msty {})
  ];
}
