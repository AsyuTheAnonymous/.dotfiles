{...}: {
  # Routing
  imports = [
    # Hardware config (MOST ESSENTIAL)
    ./hardware-configuration.nix
    # Desktop Environments
    # ./../env/wayfire/wayfire.nix
    ./../Environments/Hyprland/hypr.nix
    # Modules & Packages
    ./../../Modules/Desktop/desktop.nix
    # Custom Modules
    # ./../../Modules/Custom/custom.nix
    # Stylix
    ./../../Modules/Common/Stylix/desktop.nix
    # System Settings
    ./../../System/Desktop/desktop.nix
    # User
    ./../../Users/Desktop/asyu.nix
    # Hypervisor
    # ./../../Hypervisor/hv.nix
  ];
  # Hostname
  networking.hostName = "asyus-system";
  # Flake Support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Never change this value shit will break + doesnt affect channels
  # system.stateVersion = "24.11";
  # Me literally not taking my own advice
  system.stateVersion = "25.05";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
    "mbedtls-2.28.10"
  ];
  nixpkgs.config.allowUnfree = true;
}
