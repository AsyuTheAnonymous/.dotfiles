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
    ./../Environments/kde/kde.nix
    # Modules & Packages
    ./../../Modules/Laptop/laptop.nix
    # Bug Bounty Environment - NEW!
    ./../../Modules/Laptop/bug-bounty.nix
    # System Settings
    ./../../System/Laptop/laptop.nix
    # User
    ./../../Users/Laptop/asyu.nix
    # Stylix
    ./../../Modules/Common/Stylix/laptop.nix
  ];
  
  # Hostname
  networking.hostName = "asyus-laptop";

  # Flake Support + Nix Command
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # Additional laptop-specific settings
  
  # Enable TLP for better battery life
  services.tlp = {
    enable = true;
    settings = {
      # CPU frequency settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Power saving settings
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      # Disk settings
      DISK_IOSCHED = "mq-deadline";
      
      # PCIe power management
      PCIE_ASPM_ON_BAT = "powersave";
      
      # Platform profile settings
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };
  
  # Enable powertop auto-tune
  powerManagement.powertop.enable = true;
  
  # Enable auto-cpufreq for dynamic CPU frequency management
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Never change this value shit will break
  system.stateVersion = "24.11";
}