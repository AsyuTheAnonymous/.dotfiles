{ config, lib, pkgs, ...}:

{


    # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  # May move this to a better location
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      flake = "nix flake update";
      rebuild = "sudo nixos-rebuild switch --flake .";
      home = "home-manager switch --flake .";
      clean = "nix-env --delete-generations 5d";
      cleanhm = "home-manager expire-generations '-5 days'";
      gc = "sudo nix-collect-garbage -d"
    };
  };

 
}