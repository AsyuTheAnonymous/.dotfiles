{
  config,
  lib,
  pkgs,
  ...
}: {
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    udisks
  ];
}
