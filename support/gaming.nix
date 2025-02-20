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
    mangohud
  ];
  # 32 bit DRI Support for steam
  hardware.graphics.enable32Bit = true;

  # Game Mode + Game Scope + Mangohud usage
  # - launch properties
  # - gamemoderun %command%, mangohud %command%, gamescope %command%
}