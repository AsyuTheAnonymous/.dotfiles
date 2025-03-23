{...}: {
  imports = [
    ./gaming/gaming.nix
    ./flatpak/flatpak.nix
    ./ai/ollama.nix
    ./tablet/tablet.nix
    ./virtualization/virtualization.nix
    ./git/git.nix
  ];
}
