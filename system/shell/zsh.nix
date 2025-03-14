{ pkgs, ...}:

{


    # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  # May move this to a better location
  users.defaultUserShell = pkgs.zsh;

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      flake = "nix flake update";
      unlock = "sudo chown asyu:users /home/asyu/.dotfiles/flake.lock";
      rebuild-desktop = "sudo nixos-rebuild switch --flake .#desktop";
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
      clean = "nix-env --delete-generations 5d";
      cleanhm = "home-manager expire-generations '-5 days'";
      gc = "sudo nix-collect-garbage -d";
    };
    interactiveShellInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
  environment.etc = {
    # "hypr/hyprland.conf".source = ../env/hypr/hyprland.conf;
    # "hypr/hypridle.conf".source = ../env/hypr/hypridle.conf;
    # "ghostty/config".source = ../env/hypr/configs/ghostty/config;
    # "rofi/config.rasi".source = ../env/hypr/configs/rofi/config.rasi;
    # "rofi/catppuccin-mocha.rasi".source = ../env/hypr/configs/rofi/catppuccin-mocha.rasi;
    # "neofetch/config.conf".source = ../env/hypr/configs/neofetch/config.conf;
    # "hypr/hyprpaper.conf".source = ../env/hypr/hyprpaper.conf;
    "starship.toml".source = ../env/hypr/configs/starship/starship.toml;
    # "waybar".source = ../env/hypr/configs/waybar;
    # "vesktop/themes".source = ../../support/vesk-themes;
  };
    # export STARSHIP_CONFIG=${../../hosts/env/hypr/configs/starship/starship.toml}

}
