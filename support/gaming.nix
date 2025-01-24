{ config, lib, pkgs, ... }:

{
  # Enable Game Mode
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    lutris
    heroic
    wine
    winetricks
    mangohud
  ];

  # Game Mode + Game Scope + Mangohud usage
  # - launch properties
  # - gamemoderun %command%, mangohud %command%, gamescope %command%
}