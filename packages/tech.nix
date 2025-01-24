{config, pkgs, lib, ... }:


{
  environment.systemPackages = with pkgs; [
    vscode
    zed-editor
    impression
    gnome-boxes
    # Tools
    unzip
    unrar
    nix-tree
  ];
}