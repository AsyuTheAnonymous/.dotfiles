{...}: {
  imports = [
    ./audio/pipewire.nix
    ./bootloader/grub.nix
    ./fonts/nerd.nix
    ./network/config.nix
    ./shell/zsh.nix
  ];
}
