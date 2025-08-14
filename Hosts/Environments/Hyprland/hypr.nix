{pkgs, lib, ...}: {
  # Enable X11 Windowing System
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };
  # Polkit
  security.polkit.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = lib.mkDefault true;
  };
  # KDE Requirements
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Some Hyprland Dependencies
  programs.hyprland.xwayland = {
    # hidpi = true;
    enable = true;
  };

  # Pipewire pulse
  # services.pipewire.pulse.enable = true;

  # REQUIREMENTS
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    waybar
    hyprpaper
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

  # Point vulkan driver, gpu not detected otherwise
  environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

  # XDG Portal
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
    ];
    # Fallback for random apps
    config.common.default = [ "gtk" ];
    # When in Hyprland, prefer Hyprland portal (then gtk fallback)
    config.hyprland.default = [ "hyprland" "gtk" ];
    # When in Plasma, use KDE portal
    config.plasma.default = [ "kde" ];
  };
}
