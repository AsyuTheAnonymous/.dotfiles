{ config, pkgs, lib, ... }:

{
  stylix = {
    # Enable Stylix
    enable = true;
    # Base16 color scheme
    base16Scheme = {
      # You can use a file path to a JSON or YAML file
      # path = ./path/to/your/scheme.yaml;
      
      # Or define colors inline (based on Catppuccin Macchiato from your waybar config)
      scheme = "Catppuccin Macchiato";
      base00 = "#24273a"; # base
      base01 = "#1e2030"; # mantle
      base02 = "#363a4f"; # surface0
      base03 = "#494d64"; # surface1
      base04 = "#5b6078"; # surface2
      base05 = "#cad3f5"; # text
      base06 = "#f4dbd6"; # rosewater
      base07 = "#b7bdf8"; # lavender
      base08 = "#ed8796"; # red
      base09 = "#f5a97f"; # peach
      base0A = "#eed49f"; # yellow
      base0B = "#a6da95"; # green
      base0C = "#8bd5ca"; # teal
      base0D = "#8aadf4"; # blue
      base0E = "#c6a0f6"; # mauve
      base0F = "#f5bde6"; # pink
    };
    
    # Set a wallpaper (you can use the one from your SDDM config)
    image = ./../../../system/wallpapers/solo.jpg;
    
    # Configure fonts
    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font";
      };
      
      sansSerif = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font";
      };
      
      monospace = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font Mono";
      };
      
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    
    # Configure cursor
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Jeroo";
      size = 16;
    };
  };
}