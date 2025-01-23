{ config, lib, pkgs, pkgs-unstable, ... }:

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };
  
  # Enable virtualization
  virtualisation.libvirtd.enable = true;

  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Flake Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Never change this value shit will break
  system.stateVersion = "24.11"; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}

