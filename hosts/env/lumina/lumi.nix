{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.desktopManager.lumina.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
