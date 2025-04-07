{...}: {
  imports = [
    ./helpers/nh/nh.nix
    ./support/gaming/gaming.nix
    ./support/flatpak/flatpak.nix
    ./ai/ollama.nix
    ./support/tablet/tablet.nix
    ./support/virtualization/virtualization.nix
    ./support/git/git.nix
    ./emacs/emacs.nix
  ];
}
