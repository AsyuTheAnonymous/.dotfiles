{config, ...}: {
  # Enable the NVIDIA driver
  services.xserver.videoDrivers = ["nvidia"];

  # Hardware
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # OpenGL deprecated use hardware.graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
