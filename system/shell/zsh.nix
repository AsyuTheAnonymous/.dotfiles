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
      export STARSHIP_CONFIG=${../../hosts/env/hypr/configs/starship/starship.toml}
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      ${pkgs.neofetch}/bin/neofetch
    '';
  };


}
