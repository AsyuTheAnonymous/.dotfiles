{
  config,
  pkgs,
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

  # Display manager config - allows choosing between XFCE and Wayfire
  services.displayManager.defaultSession = "xfce";

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
  ];

  # Enable XDG Desktop Portal
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    wlr.enable = true; # Add Wayland portal support
    config = {
      common = {
        default = ["gtk"];
      };
      wayfire = {
        default = ["gtk" "wlr"];
      };
    };
  };
}