{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./flatpak.nix
    ./virtualization/virtualization.nix
  ];
}
