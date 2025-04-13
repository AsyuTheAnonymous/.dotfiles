{pkgs, lib, ...}: {
  # Enable wayfire
  programs.wayfire = {
    enable = true;
  };

  # Plugins
  programs.wayfire.plugins = with pkgs.wayfirePlugins; [
    wcm
    wf-shell
    wayfire-plugins-extra
  ];
  # XWayland Support
  services.displayManager.sessionPackages = [pkgs.wayfire];

  services.displayManager.sddm = {
    wayland.enable = true;
    # Add any other SDDM-specific settings here
  };

  # DBUS
  services.dbus = {
    enable = true;
    packages = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-wlr ];
  };
  # RTkit
  security.rtkit.enable = true;
  systemd.user.services.xdg-desktop-portal-gtk = {
    enable = false;
  };

  # XDG
  xdg.portal = {
    wlr.enable = true;
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      # pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = ["wlr"]; # Force wlr as default
      };
      # Explicitly set the preferred portals for different interfaces
      wayfire = {
        default = ["wlr"];
        screenshot = ["wlr"];
        screencast = ["wlr"];
      };
    };
  };

  # Wayland-specific environment variables
  environment.sessionVariables = {
    # NVIDIA-specific
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # General Wayland
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    
    # XDG Portal
    XDG_CURRENT_DESKTOP = "wayfire";
    XDG_SESSION_TYPE = "wayland";
  };

  # Packages
  environment.systemPackages = with pkgs; [
    swaynotificationcenter
    libnotify
    polkit_gnome
    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xwayland
    starship
    # Additional recommended packages
    wl-clipboard
    grim         # Screenshot utility
    slurp        # Screen area selection
    waybar       # Status bar
    mako         # Notification daemon
    kanshi       # Output management
    swayidle     # Idle management
    swaylock     # Screen locking
    wlroots      # Required for proper functionality
  ];


  # Security polkit settings
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Point Vulkan Driver
  # environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
}
