{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hacking/eth.nix
    ./common.nix
    ./unstable/laptop.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    libreoffice
    (pkgs.callPackage ./custom/msty {})
  ];
}
