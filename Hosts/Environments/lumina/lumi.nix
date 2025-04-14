{pkgs, ...}: {
  services.xserver = {
    enable = true;
    desktopManager.lumina.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
