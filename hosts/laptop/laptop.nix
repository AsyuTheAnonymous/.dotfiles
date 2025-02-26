{ config, lib, pkgs, ... }: {

  imports = [
    # Hardware config (MOST ESSENTIAL)
    ./hardware-configuration.nix
    # Desktop Environments
    ./../env/kde/kde.nix
    # Packages
    ./../../packages/laptop.nix
    # System Settings
    ./../../system/laptop-settings.nix
    # Support for resources
    ./../../support/laptop-settings.nix
    # Stylix 
    # ./../env/stylix/stylix.nix
  ];
  networking.hostName = "asyus-laptop";
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