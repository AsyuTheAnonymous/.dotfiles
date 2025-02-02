{ pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    # For git management
    vscode
    # For Zed
    zed-editor
    nixd
    nil
    bottles
    impression
    gnome-boxes
    # Tools
    unzip
    unrar
    nix-tree
    android-tools
  ];


}
