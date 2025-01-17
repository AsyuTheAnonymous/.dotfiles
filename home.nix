{ config, pkgs, inputs, nix-colors, catppuccin, ... }:

{
  imports = [
    ./support/zsh.nix
  ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "asyu";
  home.homeDirectory = "/home/asyu";

  # Set-up Github repo
  programs.git= {
    enable = true;
    userName = "AsyuTheAnonymous";
    userEmail = "asyutheanonymous@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };


  # Deprecating soon
  # catppuccin.gtk.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.waybar = {
    enable = true;
    #style = ./desktop/hypr/configs/waybar/style.css;
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr/hyprland.conf".source = ./desktop/hypr/hyprland.conf;
    ".config/ghostty/config".source = ./desktop/hypr/configs/ghostty/config;
    ".config/rofi/config.rasi".source = ./desktop/hypr/configs/rofi/config.rasi;
    ".config/rofi/catppuccin-mocha.rasi".source = ./desktop/hypr/configs/rofi/catppuccin-mocha.rasi;
    ".config/neofetch/config.conf".source = ./desktop/hypr/configs/neofetch/config.conf;
    ".config/hypr/hyprpaper.conf".source = ./desktop/hypr/hyprpaper.conf;
    ".config/starship.toml".source = ./desktop/hypr/configs/starship/starship.toml;
    ".config/waybar/style.css".source = ./desktop/hypr/configs/waybar/style.css;
    ".config/waybar/config.jsonc".source = ./desktop/hypr/configs/waybar/config.jsonc;
    ".config/waybar/macchiato.css".source = ./desktop/hypr/configs/waybar/macchiato.css;
  };
  # These work future me!!
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";


  # This also works yo!!
  gtk.theme.name = "Sweet-Ambar-Blue-Dark";
  gtk.theme.package = pkgs.sweet;
  
  # GTK Themes
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
  #     package = pkgs.catppuccin-gtk;
  #   };
  #   iconTheme = {
  #     name = "Juno";
  #     package = pkgs.juno-theme;

  #   };
  # };

  # # Dconf for nemo
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
  #     icon-theme = "Juno";
  #   };
  # };













  # Starship and Neofetch + ZSH Enabled
  programs.zsh = {
    enable = true;
    initExtra = ''
      neofetch
      eval "$(starship init zsh)"
    '';
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



  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
