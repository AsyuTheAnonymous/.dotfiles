{ pkgs, ... }:

{

  # Insert System Modules
  imports =
    [ # Move hardware-configuration.nix from /etc/nixos/ into this folder if you switch to laptop/desktop
      ./system/hardware-configuration.nix
      # Desktop Environments
      ./desktop/settings.nix
      # Packages
      ./packages/settings.nix
      # System Settings
      ./system/settings.nix
      # Support for resources
      ./support/settings.nix
    ];


  # Dude its literally just your hostname..
  networking.hostName = "asyus-system";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # Flake Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Never change this value shit will break
  system.stateVersion = "24.11";


}
