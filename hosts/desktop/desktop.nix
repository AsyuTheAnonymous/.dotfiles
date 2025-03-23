{...}: {
  # Routing
  imports = [
    # Hardware config (MOST ESSENTIAL)
    ./hardware-configuration.nix
    # Desktop Environments
    ./../env/hypr/hypr.nix
    # Packages
    ./../../packages/desktop.nix
    # System Settings
    ./../../system/desktop.nix
    # Support for resources
    ./../../support/desktop.nix
    # User
    ./../../user/asyu.nix
    # Stylix
    ./../env/stylix/desktop.nix
    # Modules
    ./../../modules/desktop.nix
  ];
  # Hostname
  networking.hostName = "asyus-system";

  # Flake Support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Never change this value shit will break
  system.stateVersion = "24.11";
}
