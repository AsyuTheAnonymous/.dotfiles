{config, pkgs, lib, ... }:


{
  environment.systemPackages = with pkgs; [
    vscode
    impression
    gnome-boxes
    # Tools
    unzip
    unrar
  ];
}