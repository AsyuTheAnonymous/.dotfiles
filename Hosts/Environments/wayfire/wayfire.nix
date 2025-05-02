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

  # Enable XDG Portal with wlr backend for better Wayland app integration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.wayfire.default = [ "wlr" "gtk" ];
  };

  # Additional packages that work well with Wayfire
  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard utilities for Wayland
    grim # Screenshot utility
    slurp # Region selection utility (for screenshots)
    mako # Notification daemon
    wofi # Application launcher
    kanshi # Output management
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
  };

  # Configure fontconfig for better font rendering
  fonts.fontconfig.enable = true;
}