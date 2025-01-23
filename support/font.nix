{ config, lib, pkgs, ... }:

{
  # Enabling nerdfonts
  fonts.packages = with pkgs; [ nerdfonts ];
  fonts.fontconfig.enable = true;
  
}