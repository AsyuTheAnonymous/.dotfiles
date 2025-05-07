{
  config,
  pkgs,
  ...
}: {
  # Keep X server for XWayland support
  services.xserver = {
    enable = true;
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
    blueman

    # Core
    wlroots
    wf-recorder
    # wayfirePlugins.wcm
    # wayfirePlugins.wf-shell
    xdg-desktop-portal-wlr
    xorg.xrandr
    xorg.xprop
    xorg.xwininfo
    xorg.xinput
    xwayland
    
    # 
    wl-clipboard
    libinput
    cairo

    # Plugins
    wayfirePlugins.windecor
    # wayfirePlugins.wayfire-plugins-extra
  ];

  # Configure XDG Desktop Portal for Wayfire
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-wlr  # Use WLR portal for Wayland
      xdg-desktop-portal-gtk
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
  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   gtkUseWayland = true; 
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gtk
  #   ];
  #   config = {
  #     common = {
  #       default = ["gtk" "wlr"];
  #     };
  #     wayfire = {
  #       default = ["wlr"];
  #       "org.freedesktop.portal.ScreenCast" = {
  #         default = ["gtk" "wlr"];
  #       };
  #       "org.freedesktop.portal.FileChooser" = {
  #         default = ["gtk" "wlr"];
  #       };
  #     };
  #   };
  # };
  
  # # Enable seat management for Wayfire
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd wayfire";
  #       user = "greeter";
  #     };
  #   };
  # };
  hardware.uinput.enable = true;
  security.polkit.enable = true;

  
  # Required services for Wayfire
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
}