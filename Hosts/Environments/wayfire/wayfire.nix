{
  config,
  pkgs,
  ...
}: {
  # Keep X server for XWayland support
  services.xserver = {
    enable = true;
    # Remove XFCE desktop manager
    # desktopManager.xfce.enable = false; -- You can just remove this section entirely
    
    # NVIDIA configuration for RTX 3080
    videoDrivers = ["nvidia"];
  };

  # Enable Wayfire
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
    xwayland.enable = true;
  };

  # UWSM configuration for Wayfire
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

  # Set Wayfire as default session
  services.displayManager.defaultSession = "wayfire";
  # Core packages
  environment.systemPackages = with pkgs; [
    # Keep themes
    papirus-icon-theme
    adwaita-qt
    adwaita-icon-theme
    
    # Keep utilities
    starship
    rofi
    wdisplays

    # Tray
    networkmanagerapplet

    # Core
    wlroots
    wayfirePlugins.wcm
    wayfirePlugins.wf-shell
    xdg-desktop-portal-wlr
    
    # 
    wl-clipboard
    libinput

    # Plugins
    wayfirePlugins.windecor
    wayfirePlugins.wayfire-plugins-extra
  ];

  # Configure XDG Desktop Portal for Wayfire
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-wlr  # Use WLR portal for Wayland
    ];
    config = {
      common = {
        default = ["wlr"];
      };
      wayfire = {
        default = ["wlr"];
      };
    };
  };
  
  # Required services for Wayfire
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
}