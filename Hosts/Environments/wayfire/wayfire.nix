{
  config,
  pkgs,
  lib,
  ...
}: {
  # Basic XFCE setup as fallback
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    videoDrivers = ["nvidia"];  # NVIDIA configuration
  };
  
  # Default to Wayfire session
  services.displayManager.defaultSession = "wayfire";

  # Enable Wayfire
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm          # Config manager
      wf-shell     # Panel and dock
    ];
    xwayland.enable = true;
  };

  # UWSM configuration - minimal but essential
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      wayfire = {
        prettyName = "Wayfire";
        comment = "Wayfire compositor";
        binPath = "/run/current-system/sw/bin/wayfire";
      };
    };
  };

  # Basic packages
  environment.systemPackages = with pkgs; [
    # Original packages you need
    picom
    rofi
    starship
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    
    # Essential portals
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];

  # Configure XDG Portal - essential minimum
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    # Minimal portal config
    config.wayfire.default = ["wlr" "gtk"];
  };
  
  # Required services
  services.dbus.enable = true;
  security.rtkit.enable = true;
  
  # Enable PipeWire for screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}