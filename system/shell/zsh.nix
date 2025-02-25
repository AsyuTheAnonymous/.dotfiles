{ pkgs, ...}:

{


    # ZSH Default Shell
  environment.shells = with pkgs; [ zsh ];
  # May move this to a better location
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      flake = "nix flake update";
      rebuild-desktop = "sudo nixos-rebuild switch --flake .#desktop";
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
      home-desktop = "home-manager switch --flake .#asyu@desktop";
      home-laptop = "home-manager switch --flake .#asyu@laptop";
      clean = "nix-env --delete-generations 5d";
      cleanhm = "home-manager expire-generations '-5 days'";
      gc = "sudo nix-collect-garbage -d";
    };
  };


}
