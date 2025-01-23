{ config, pkgs, inputs, ... }:

{
  # Enable themes for GTK apps (file managers and other apps use GTK)
  gtk.enable = true;

  # Theme
  gtk.theme = {
    package = pkgs.sweet;
    name = "Sweet-Ambar-Blue-Dark-v40";
  };

  # Icons
  gtk.iconTheme = {
    package = pkgs.candy-icons;
    name = "candy-icons";
  };

  # Cursor
  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
  };
}