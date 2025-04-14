{pkgs, ...}: {
  # ZSH Default Shell
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      test = "nh os switch --dry";
    };
    interactiveShellInit = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
