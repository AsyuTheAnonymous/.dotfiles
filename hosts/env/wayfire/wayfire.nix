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

  # XDG
  services.dbus.enable = true; # Required for portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      # pkgs.xdg-desktop-portal-gtk
    ];
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
  # environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
}
