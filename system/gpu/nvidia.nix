{ config, lib, pkgs, ... }:

{

  # Enable the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
 


  # Hardware
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
