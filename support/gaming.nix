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
    protonup
    lutris
    heroic
    mangohud
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/asyu/.steam/compatibilitytools.d";
  };
  # Game Mode + Game Scope + Mangohud usage
  # - launch properties
  # - gamemoderun %command%, mangohud %command%, gamescope %command%
}