{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./flatpak/flatpak.nix
    ./virtualization/virtualization.nix
    ./git/git.nix
  ];
}
