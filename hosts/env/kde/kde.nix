{
  config,
  lib,
  pkgs,
  ...
}: {
  # KDE Requirements
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Add only essential packages
  environment.systemPackages = with pkgs; [
    kate
  ];
}
