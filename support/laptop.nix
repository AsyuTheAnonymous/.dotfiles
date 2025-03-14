{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./flatpak/flatpak.nix
    ./virtualization/virtualization.nix
  ];
}
