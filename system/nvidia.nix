{config, lib, pkgs, ...}:

{

  # Nvidia Drivers (Open drivers)
  hardware.nvidia.open = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  
}