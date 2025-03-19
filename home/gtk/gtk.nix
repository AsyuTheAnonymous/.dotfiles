{
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };
}
