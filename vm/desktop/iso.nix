{ lib, config, ... }:

{
  # 1. Filesystem Overrides
  # Remove specific mounts defined elsewhere using lib.mkForce to ensure override
  fileSystems = lib.mkForce {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ]; # Define root as tmpfs for the ISO
    };
    # Root ("/") and boot ("/boot") are typically handled by the ISO build process
    # or the VM's disk partitioning, so we remove the hardcoded ones from
    # hardware-configuration.nix and system/drives/drives.nix.
  };

  # Remove swap devices defined in hardware-configuration.nix
  swapDevices = lib.mkForce [];

  # Remove NTFS support added in system/drives/drives.nix unless specifically needed in VM
  # It checks if "ntfs" exists in the original list before removing.
  # boot.supportedFilesystems = lib.mkForce (lib.remove "ntfs" config.boot.supportedFilesystems);

  # 2. GPU Overrides
  # Disable Nvidia hardware settings from system/gpu/nvidia.nix
  # hardware.nvidia.enable = lib.mkForce false;
  # Explicitly disable Nvidia in Xserver drivers list
  services.xserver.videoDrivers = lib.mkForce [ "modesetting" ]; # Use generic modesetting driver

  # Keep generic graphics enabled (required by modesetting)
  hardware.graphics.enable = lib.mkForce true;
  hardware.graphics.enable32Bit = lib.mkForce true; # Keep if 32-bit support is needed

  # 3. AI Module (Ollama) Override
  # Disable the Ollama service from modules/ai/ollama.nix
  services.ollama.enable = lib.mkForce false;

  # 4. ISO/VM Specific Settings
  # Ensure bootloader isn't trying to install to a specific device (usually handled by nixos-generators for ISO)
  boot.loader.grub.device = lib.mkForce "nodev"; # Uncomment if needed, often helps for ISO builds
  boot.loader.grub.enable = lib.mkForce true;
  # --- Add Guest Utilities for Virt-Manager (QEMU/KVM) ---
  services.spice-vdagentd.enable = true; # Enables clipboard sharing, dynamic resolution via Spice
  services.qemuGuest.enable = true;      # General QEMU guest agent
  # Ensure virtio drivers are available early in boot for better performance
  # boot.initrd.availableKernelModules = config.boot.initrd.availableKernelModules ++ [ "virtio_pci" "virtio_blk" "virtio_net" "virtio_console" ];

  # Ensure basic network works (DHCP was default in hardware-config, should be fine)
  networking.useDHCP = lib.mkDefault true;
}
