{ config, pkgs, ... }:

{
  # Basic XFCE setup with disabled Xfwm4
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = false;  # Disable XFCE's window manager
      };
    };
    # displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";
    
    # NVIDIA configuration for RTX 3080
    videoDrivers = [ "nvidia" ];
  };
  
#   # NVIDIA specific settings
#   nixpkgs.config.allowUnfree = true;
#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = true;
#     package = config.boot.kernelPackages.nvidiaPackages.stable;
#     nvidiaSettings = true;
#   };
  
#   # Hardware acceleration
#   hardware.graphics.enable = true;
#   hardware.opengl = {
#     enable = true;
#     driSupport = true;
#     driSupport32Bit = true;
#   };
  
  # Install Compiz
  environment.systemPackages = with pkgs; [
    compiz
    compizConfig
    
    # Additional XFCE plugins
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    
    # Themes
    arc-theme
    papirus-icon-theme

    # Additional
    starship
    networkmanagerapplet
  ];
  
  # Session startup commands to replace xfwm4 with compiz
  services.xserver.desktopManager.xfce.extraSessionCommands = ''
    # Kill xfwm4 if it's running and start compiz
    pkill xfwm4 || true
    compiz --replace ccp &
  '';
}