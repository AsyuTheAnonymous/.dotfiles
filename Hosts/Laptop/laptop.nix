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
    ./../Environments/lumina/lumi.nix
    # Modules & Packages
    ./../../Modules/Laptop/laptop.nix
    # System Settings
    ./../../System/Laptop/laptop.nix
    # User
    ./../../User/Laptop/asyu.nix
    # Stylix
    # ./../../Modules/Common/Stylix/laptop.nix
  ];
  # Hostname
  networking.hostName = "asyus-laptop";

  # Flake Support + Nix Command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Never change this value shit will break
  system.stateVersion = "24.11";
}
