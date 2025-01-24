{config, pkgs, lib, ... }:


{
  environment.systemPackages = with pkgs; [
    # For git management
    vscode
    # For Zed
    zed-editor
    nixd
    nil
    impression
    gnome-boxes
    # Tools
    unzip
    unrar
    nix-tree
  ];
}
