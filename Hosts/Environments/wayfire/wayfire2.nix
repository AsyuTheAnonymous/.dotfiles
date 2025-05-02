{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Enable Wayfire compositor
  programs.wayfire = {
    enable = true;
    
    # Configure plugins
    plugins = with pkgs.wayfirePlugins; [
      wcm # Wayfire Config Manager
      wf-shell # GTK-based panel for Wayfire
      wayfire-plugins-extra # Additional plugins
    ];
    
    # Enable XWayland support (true by default)
    xwayland.enable = true;
  };

  # Update your existing SDDM configuration to support Wayland
  services.displayManager.sddm.wayland.enable = true;

  # CRITICAL: Enable rtkit for realtime scheduling - this is missing in your config
  security.rtkit.enable = true;

  # Configure pipewire with rtkit for audio
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment this
#     # jack.enable = true;
#   };

  # XDG Portal configuration - properly configured for Wayfire
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
    ];
    # Configure portals with proper order
    config = {
      # Set Wayfire to use these portals in this order
      wayfire = {
        default = [ "wlr" "gtk" ];
      };
      # Fallback for common portals
      common = {
        default = [ "wlr" "gtk" ];
      };
    };
    # Explicitly configure wlr portal settings
    wlr.settings = {
      screencast = {
        # Choose preferred method: "DBUS" or "wlroots"
        chooser_type = "simple";
        # Adjust timeout (in ms) to resolve potential timing issues
        chooser_timeout = 60000; # 60 seconds instead of default 30
      };
    };
  };

  # Additional packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    wl-clipboard # Clipboard utilities for Wayland
    grim # Screenshot utility
    slurp # Region selection utility (for screenshots)
    mako # Notification daemon
    wofi # Application launcher
    kanshi # Output management
    # Add rtkit to ensure it's properly available
    rtkit
  ];

  # Configure environment variables for Wayland
  environment.sessionVariables = {
    # Enable Wayland for Firefox
    MOZ_ENABLE_WAYLAND = "1";
    # Enable Wayland for Qt applications
    QT_QPA_PLATFORM = "wayland";
    # Enable Wayland for SDL2 applications
    SDL_VIDEODRIVER = "wayland";
    # Enable Wayland for EFL applications
    ECORE_EVAS_ENGINE = "wayland";
    ELM_ENGINE = "wayland";
    # XDG specification for Wayland
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Wayfire";
    # Prefer the Wayland backend for GTK applications
    GDK_BACKEND = "wayland";
    # Explicitly set this to avoid portal timing out
    XDG_DESKTOP_PORTAL_DIR = "/run/current-system/sw/share/xdg-desktop-portal/portals";
  };

  # Configure systemd user services for the portals
  systemd.user.services = {
    # Extend the timeout for xdg-desktop-portal
    "xdg-desktop-portal" = {
      serviceConfig = {
        # Increase timeout to prevent service failing
        TimeoutStartSec = "1min";
      };
    };
    # Same for gtk portal
    "xdg-desktop-portal-gtk" = {
      serviceConfig = {
        TimeoutStartSec = "1min";
      };
    };
    # Same for wlr portal
    "xdg-desktop-portal-wlr" = {
      serviceConfig = {
        TimeoutStartSec = "1min";
      };
    };
  };

  # Create a custom wayfire-portals.conf to ensure proper portal selection
  environment.etc."xdg-desktop-portal/wayfire-portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.Screenshot=wlr
    org.freedesktop.impl.portal.ScreenCast=wlr
  '';

  # Configure fontconfig for better font rendering
  fonts.fontconfig.enable = true;
}