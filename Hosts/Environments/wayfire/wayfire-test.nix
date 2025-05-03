{
  config,
  pkgs,
  lib,
  ...
}: {
  # Keep XFCE setup alongside Wayfire
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;
      };
    };
    
    # Session commands for X11 sessions
    displayManager = {
      sessionCommands = ''
        if [ "$XDG_SESSION_DESKTOP" = "wayfire" ]; then
          export XDG_CURRENT_DESKTOP=Wayfire
          export XDG_SESSION_TYPE=wayland
          # For NVIDIA-specific compatibility
          export WLR_NO_HARDWARE_CURSORS=1
        fi
      '';
    };
  };
  
  # Use this option in NixOS 24.11
  services.displayManager.defaultSession = "wayfire";

  # Enable Wayfire with default configuration
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
    xwayland.enable = true;
  };

  # NVIDIA configuration for RTX 3080
  services.xserver.videoDrivers = ["nvidia"];
  
  # Enable UWSM - the Wayland Session Manager (new in NixOS 24.11)
  # With the correct format for waylandCompositors
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      wayfire = {
        prettyName = "Wayfire";
        comment = "Wayfire compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/wayfire";
      };
    };
  };

  # Install packages
  environment.systemPackages = with pkgs; [
    # Original packages
    picom
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    arc-theme
    papirus-icon-theme
    starship
    rofi
    networkmanagerapplet
    
    # Essential Wayfire tools
    wayfirePlugins.wcm
    wayfirePlugins.wf-shell

    # Portal dependencies
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-utils
    
    # DBus utilities
    dbus
  ];

  # Set global environment variables
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    # Explicitly enable portal usage
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # Configure XDG Portal
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    
    # Setting explicit portal configurations
    config = {
      common = {
        default = ["gtk"];
      };
      # Special configuration for Wayfire (both case variants)
      Wayfire = {
        default = ["wlr" "gtk"];
      };
      wayfire = {
        default = ["wlr" "gtk"];
      };
    };
    
    # Ensure portals are properly configured
    configPackages = [ pkgs.wayfire ];
  };
  
  # Enable D-Bus
  services.dbus = {
    enable = true;
    packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    implementation = "broker"; # Use dbus-broker for better compatibility
  };
  
  # Enable PipeWire for screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  # Enable RealtimeKit (addresses the error in logs)
  security.rtkit.enable = true;
  
  # Create portal configuration files
  environment.etc."xdg/xdg-desktop-portal/Wayfire-portals.conf".text = ''
    [preferred]
    default=wlr;gtk
    org.freedesktop.impl.portal.ScreenCast=wlr
    org.freedesktop.impl.portal.Screenshot=wlr
  '';
  
  environment.etc."xdg/xdg-desktop-portal/wayfire-portals.conf".text = ''
    [preferred]
    default=wlr;gtk
    org.freedesktop.impl.portal.ScreenCast=wlr
    org.freedesktop.impl.portal.Screenshot=wlr
  '';
}