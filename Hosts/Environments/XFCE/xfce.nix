{ config, pkgs, ... }:

{
  # Basic XFCE setup with disabled Xfwm4
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;  # Disable XFCE's window manager
      };
    };
    
    # # SDDM display manager
    # displayManager.sddm = {
    #   enable = true;
    #   theme = "breeze";
    # };
  };
  
  # Updated path for defaultSession in NixOS 24.11
  services.displayManager.defaultSession = "xfce";
  
  # NVIDIA configuration for RTX 3080
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # Install Picom instead of Compiz (which isn't available)
  environment.systemPackages = with pkgs; [
    # Use picom instead of compiz
    picom
    
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
  
  # Use updated path for session commands in NixOS 24.11
  # services.xserver.displayManager.sessionCommands = ''
  #   # Kill xfwm4 if it's running and start picom
  #   pkill xfwm4 || true
  #   picom --experimental-backends --backend glx --vsync &
  # '';

  # Enable XDG Desktop Portal
  xdg.portal = {
    enable = true;
    # Specify the portal implementation to use
    xdgOpenUsePortal = true;
    # For XFCE, you'll want the GTK portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # Configure portal settings
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };
  

}