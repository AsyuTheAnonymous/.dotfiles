{...}: {
  imports = [
    ./helpers/nh/nh.nix
    ./support/flatpak/flatpak.nix
    ./support/virtualization/virtualization.nix
    ./support/git/git.nix
    ./emacs/emacs.nix
  ];
}
