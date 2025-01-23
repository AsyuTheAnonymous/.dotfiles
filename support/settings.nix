{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./gaming.nix
    ./flatpak.nix
    ./font.nix
    ./ai/ollama.nix
  ];
  services.ollama = {
    enable = true;
    models = "/run/media/asyu/Vault/Models";
  };



}