{ pkgs, ...}:

{
  # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      flake = "nix flake update";
      unlock = "sudo chown asyu:users /home/asyu/.dotfiles/flake.lock";
      rebuild-desktop = "sudo nixos-rebuild switch --flake .#asyus-system";
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
      hm-desktop = "home-manager switch --flake .#asyu@desktop";
      hm-laptop = "home-manager switch --flake .#asyu@laptop";
      clean = "nix-env --delete-generations 5d";
      cleanhm = "home-manager expire-generations '-5 days'";
      gc = "sudo nix-collect-garbage -d";
    };
    interactiveShellInit = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
