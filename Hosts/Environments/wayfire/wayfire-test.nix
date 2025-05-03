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
  };

  # Add Wayfire as an alternative session
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
    xwayland.enable = true;
  };

  # Display manager config
  services.displayManager = {
    defaultSession = "xfce";
    # Set environment variables for Wayfire when it's launched
    sessionCommands = ''
      if [ "$XDG_SESSION_DESKTOP" = "wayfire" ]; then
        export XDG_CURRENT_DESKTOP=Wayfire
        export XDG_SESSION_TYPE=wayland
        # For NVIDIA-specific compatibility
        export WLR_NO_HARDWARE_CURSORS=1
      fi
    '';
  };

  # NVIDIA configuration for RTX 3080
  services.xserver.videoDrivers = ["nvidia"];

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
  ];

  # Global environment variables (available in all sessions)
  environment.sessionVariables = {
    # Make sure GTK apps use portal for file dialogs
    GTK_USE_PORTAL = "1";
  };

  # Enable XDG Desktop Portal with proper configuration
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    
    # Make sure both GTK and WLR portals are available
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    
    # Configure portal settings - explicitly match portal implementations
    # with desktop environments
    config = {
      common = {
        default = ["gtk"];
      };
      # Special configuration for Wayfire
      Wayfire = {
        default = ["wlr" "gtk"];
      };
    };
  };
  
  # Enable PipeWire for screen sharing support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  
  # Create Wayfire portals configuration file
  environment.etc."xdg/xdg-desktop-portal/Wayfire-portals.conf".text = ''
    [preferred]
    default=wlr;gtk
    org.freedesktop.impl.portal.ScreenCast=wlr
    org.freedesktop.impl.portal.Screenshot=wlr
  '';
  
  # Create a systemd user service to ensure proper environment variables
  systemd.user.services.wayfire-xdg-env = {
    description = "Set up XDG environment for Wayfire";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.writeShellScript "wayfire-xdg-env-setup" ''
        if [ "$XDG_SESSION_DESKTOP" = "wayfire" ]; then
          # Ensure proper environment variables
          systemctl --user set-environment XDG_CURRENT_DESKTOP=Wayfire
          systemctl --user set-environment XDG_SESSION_TYPE=wayland
          
          # Restart the portal services to pick up the environment variables
          systemctl --user restart xdg-desktop-portal.service
          systemctl --user restart xdg-desktop-portal-wlr.service
          systemctl --user restart xdg-desktop-portal-gtk.service
        fi
      ''}";
    };
  };
}