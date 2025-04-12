{pkgs, lib, ...}: {
  programs.wayfire = {
    enable = true;
  };
  # Enable X11 Windowing System
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };
  # Plugings
  programs.wayfire.plugins = with pkgs.wayfirePlugins; [
    wcm
    wf-shell
    wayfire-plugins-extra
  ];
  # XWayland Support
  services.displayManager.sessionPackages = [pkgs.wayfire];
  services.xserver.windowManager.session = [
    {
      name = "wayfire";
      start = ''
        ${pkgs.wayfire}/bin/wayfire
      '';
    }
  ];
  # XDG
  services.dbus.enable = true; # Required for portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr # Use this one
    ];
    config = {
      common = {
        default = "*"; # Default fallback if no interface matches
      };
      # Prioritize wlr portal for Wayfire/WLR interfaces
      wlr = {
        default = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        # Add other interfaces if needed, but these are common
      };
    };
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
  ];
  # Point Vulkan Driver
  environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
}
