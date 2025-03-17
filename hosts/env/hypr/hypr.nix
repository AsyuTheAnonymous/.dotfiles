{ pkgs, ... }:

{

  # Enable GNOME services needed by Nautilus
  services.gnome.core-utilities.enable = true;

  # Enable GNOME Virtual File System
  services.gvfs.enable = true;



  # Enable X11 Windowing System
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
  };

  # Some Hyprland Dependencies
  programs.hyprland.xwayland = {
    # hidpi = true;
    enable = true;
  };


  # Pipewire pulse
  # services.pipewire.pulse.enable = true;

  # REQUIREMENTS
  environment.systemPackages = with pkgs; [
    waybar
    ghostty
    nemo
    adwaita-icon-theme  # For proper icon support
    gnome-themes-extra  # For additional theme support
    rofi
    hypridle
    swaynotificationcenter
    libnotify
    swww
    kitty
    polkit_gnome
    xdg-desktop-portal-hyprland
    networkmanagerapplet
    brightnessctl
    wl-clipboard
    grim
    slurp
    swappy
    qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xwayland
    starship
    hyprpaper
    catppuccin-kvantum
    bibata-cursors
  ];

  # XDG Portal
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };


}
