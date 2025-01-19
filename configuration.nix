# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # Insert System Modules
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Swap Desktops
      #./desktop/kde/kde.nix
      ./sddm.nix
      ./desktop/hypr/hypr.nix
      ./packages/essential.nix
      ./packages/unstable.nix
      ./packages/code.nix
      ./system/bootloader/grub.nix
      # Remove Nvidia module for laptop support
      ./system/nvidia.nix
      ./system/pipewire.nix
      ./system/drives.nix
      ./system/shell.nix
      ./support/steam.nix
      # ./support/zsh.nix
      ./support/ssh.nix
      ./support/flatpak.nix
  
      
    ];

    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "osu-lazer"
    ];








  # Enabling nerdfonts
  fonts.packages = with pkgs; [ nerdfonts ];
  fonts.fontconfig.enable = true;

  # Dude its literally just your hostname..
  networking.hostName = "asyus-system";

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  
  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  hardware.bluetooth.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Flake Support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # Did you read the comment?

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

