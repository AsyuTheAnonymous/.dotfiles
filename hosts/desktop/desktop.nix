{ config, lib, pkgs, ... }: {

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
  ];
  networking.hostName = "asyus-system";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ];
    packages = with pkgs; [
    ];
  };

  # Flake Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Never change this value shit will break
  system.stateVersion = "24.11";





}