Steps to rebuild system w dotfiles

Modify /etc/nixos/configuration.nix:
  # Add Nvidia Drivers
  hardware.nvidia.open = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  # Disable this on fresh config using gnome
  #boot.loader.systemd-boot.enable = true;
  
  # Add this
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader (Disable systemd and keep these settings the same)
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking.hostName = "asyus-system"; # Define your hostname.

  # Move hardware-configuration.nix from /etc/nixos/ into .dotfiles/system/