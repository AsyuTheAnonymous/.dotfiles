{ pkgs, lib, ... }:


{
  imports = [
    ./common.nix
    ./unstable/unstable.nix
    ./gaming/games.nix
    ./recording/obs.nix
  ];
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;
  
  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    vivaldi
    libreoffice
    tradingview
    catppuccin-sddm
    mpv
    (pkgs.callPackage ./custom/msty {}) 

  ];
}
