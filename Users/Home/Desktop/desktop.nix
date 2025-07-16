{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # ./../Common/Environments/XFCE/Display/autorandr.nix
  ];
  stylix = {
    enable = true;
    # Stylix requires an image
    image = ./../../../System/Common/wallpapers/solo.jpg;
    base16Scheme = {
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
    # Cursor
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 30;
    };
    
    # targets.gtk = {
    #   enable = true;
    # };
    # Specifying Hyprland Session
    # targets.hyprland = {
    #   enable = true;
    # };

  };
  # # Some apps need this so best suit the seem how I can!
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = lib.mkForce "rose-pine-moon";
  #     package = lib.mkForce pkgs.rose-pine-gtk-theme;
  #   };
  #   iconTheme = {
  #     name = lib.mkForce "rose-pine-moon";
  #     package = lib.mkForce pkgs.rose-pine-icon-theme;
  #   };
  # };
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "asyu";
  home.homeDirectory = "/home/asyu";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  # systemd.user.services = {
  #   "xdg-desktop-portal-gtk" = {
  #     Unit.X-Restart-Triggers = ["${config.home.profileDirectory}/etc/xdg/xdg-desktop-portal/wayfire-portals.conf"];
  #   };
  # };


  # home.activation = {
  #   changePapirusFolders = ''
  #     ${pkgs.catppuccin-papirus-folders}/bin/catppuccin-papirus-folders -C mocha -a blue --theme Papirus-Dark
  #   '';
  # };

  # Enable waybar 
  # programs.waybar = {
  #   enable = true;
  # };
  
  #Starship and Neofetch + ZSH Enabled
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(starship init zsh)"
    '';
    shellAliases = {
      linuxbest = "echo i hate windows";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".config/wayfire.ini".source = ./../../../Hosts/Environments/wayfire/wayfire.ini;
    ".config/hypr/hyprland.conf".source = ./../../../Hosts/Environments/Hyprland/hyprland.conf;
    ".config/hypr/hypridle.conf".source = ./../../../Hosts/Environments/Hyprland/hypridle.conf;
    ".config/hypr/hyprpaper.conf".source = ./../../../Hosts/Environments/Hyprland/hyprpaper.conf;
    ".config/ghostty/config".source = ./../../../Hosts/Environments/Hyprland/configs/ghostty/config;
    ".config/rofi/config.rasi".source = ./../../../Hosts/Environments/Hyprland/configs/rofi/config.rasi;
    ".config/rofi/catppuccin-mocha.rasi".source = ./../../../Hosts/Environments/Hyprland/configs/rofi/catppuccin-mocha.rasi;
    ".config/neofetch/config.conf".source = ./../../../Hosts/Environments/Hyprland/configs/neofetch/config.conf;
    ".config/starship.toml".source = ./../../../Hosts/Environments/Hyprland/configs/starship/starship.toml;
    ".config/waybar".source = ./../../../Hosts/Environments/Hyprland/configs/waybar;
    # ".config/zed/settings.json".source = ./../modules/editor/zed/settings.json;
    # ".config/zed/keymap.json".source = ./../modules/editor/zed/keymap.json;
    # ".config/zed/themes".source = ./../modules/editor/zed/themes;
    # ".config/vesktop/themes".source = ./../support/vesk-themes;
    # ".config/systemd/user/opentabletdriver.service".source = ./../support/tablet/opentabletdriver.service;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/asyu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
