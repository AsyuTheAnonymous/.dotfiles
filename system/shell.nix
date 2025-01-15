{config, lib, pkgs, ... }:

{

  # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

}