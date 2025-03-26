{pkgs, ...}: {
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
    hyprpaper
    ghostty
    # pcmanfm
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
    # hyprpaper
    catppuccin-kvantum
    bibata-cursors
  ];

  # # XDG Portal
  # services.dbus.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  # };
  # XDG Portal
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
