{ config, lib, pkgs, ...}:

{


    # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # ZSH Aliases
  programs.zsh.shellAliases = {
    flake = "nix flake update";
    rebuild = "sudo nixos-rebuild switch --flake .";
    home = "home-manager switch --flake .";
    clean = "nix-env --delete-generations 5d";
    cleanhm = "home-manager expire-generations '-5 days'";
  };







}