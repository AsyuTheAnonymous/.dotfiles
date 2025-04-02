{
  config,
  lib,
  pkgs,
  ...
}: {
  # Routing
  imports = [
    # Hardware config (MOST ESSENTIAL)
    ./hardware-configuration.nix
    # Desktop Environments
    ./../env/kde/kde.nix
    # Packages
    ./../../packages/laptop.nix
    # System Settings
    ./../../system/laptop.nix
    # User
    ./../../user/asyu.nix
    # Modules
    ./../../modules/laptop.nix
    # Stylix
    # ./../env/stylix/stylix.nix
  ];
  # Hostname
  networking.hostName = "asyus-laptop";

  # Flake Support + Nix Command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Never change this value shit will break
  system.stateVersion = "24.11";
}
