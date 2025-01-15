{ config, pkgs, ... }:

{

  # ZSH
 # programs.zsh.enable = true;


  # ZSH Aliases
  programs.zsh.shellAliases = {
    flake = "nix flake update";
    rebuild = "sudo nixos-rebuild switch --flake .";
    home = "home-manager switch --flake .";
  };
  



}