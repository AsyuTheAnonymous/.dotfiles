{ pkgs, lib, ... }:


{

  # Games
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    runelite
  ];
}
