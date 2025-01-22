{ config, lib, pkgs, pkgs-unstable, ... }:

{

  # Insert System Modules
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Swap Desktop environments
      #./desktop/kde/kde.nix
      # Remove Nvidia module for laptop support
      ./desktop/hypr/hypr.nix
      ./packages/essential.nix
      ./packages/unstable.nix
      ./packages/tech.nix
      ./system/settings.nix
      #  ./system/bootloader/grub.nix
      #  ./system/nvidia.nix
      #  ./system/pipewire.nix
      #  ./system/drives.nix
      #  ./system/shell.nix
      ./support/gaming.nix
      ./support/ssh.nix
      ./support/flatpak.nix      
    ];


  # # Lets try this again shall we
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "osu-lazer-bin"
  # ];

  # Automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;
  
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
    extraGroups = [ "wheel" "input" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  
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

