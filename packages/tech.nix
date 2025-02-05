{ pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    # For git management
    code-cursor
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

  programs.partition-manager.enable = true;

}
