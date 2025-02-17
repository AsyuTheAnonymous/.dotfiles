{ pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    # For git management
    vscode
    nixd
    nil
    bottles
    impression
    gnome-boxes
    # Tools
    unzip
    unrar
    zip
  ];


}
