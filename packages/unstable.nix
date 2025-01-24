{ config, lib, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    vesktop
    atlauncher
    # osu-lazer-bin
  ];
}