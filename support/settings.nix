{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./gaming.nix
    ./flatpak.nix
    ./font.nix
    ./ai/ollama.nix
    ./tablet/tablet.nix
   # ./ai/interpreter.nix
  ];
}
