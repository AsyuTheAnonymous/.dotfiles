{ pkgs, ... }: {

  programs.wayfire = {
    enable = true;

  };
  # Plugings
  programs.wayfire.plugins = with pkgs.wayfirePlugins; [
    wcm
    wf-shell
    wayfire-plugins-extra
  ];
  # XWayland Support
  services.xserver.displayManager.sessionPackages = [ pkgs.wayfire ];
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
      # pkgs.xdg-desktop-portal-gtk # Optionally add this if needed for GTK apps
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
  ];
  # Point Vulkan Driver
  environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

}