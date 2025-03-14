{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./gaming.nix
    ./flatpak.nix
    ./ai/ollama.nix
    ./tablet/tablet.nix
    ./virtualization/virtualization.nix
  ];
}
