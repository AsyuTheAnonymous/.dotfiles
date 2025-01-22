{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./essential.nix
    ./tech.nix
    ./unstable.nix
  ];




}